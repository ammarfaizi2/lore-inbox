Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131097AbRATXem>; Sat, 20 Jan 2001 18:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131441AbRATXec>; Sat, 20 Jan 2001 18:34:32 -0500
Received: from vitelus.com ([64.81.36.147]:35848 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S131097AbRATXeT>;
	Sat, 20 Jan 2001 18:34:19 -0500
Date: Sat, 20 Jan 2001 15:34:03 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Daniel Stone <daniel@kabuki.eyep.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and ipmasq modules
Message-ID: <20010120153403.A17269@vitelus.com>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14K7UY-0004hB-00@kabuki.eyep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14K7UY-0004hB-00@kabuki.eyep.net>; from daniel@kabuki.eyep.net on Sun, Jan 21, 2001 at 10:32:15AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 10:32:15AM +1100, Daniel Stone wrote:
> FTP is under Connection Tracking support, FTP connection tracking. Does
> the same stuff as ip_masq_ftp. IRC is located in patch-o-matic -
> download iptables 1.2 and do a make patch-o-matic, there is also RPC and
> eggdrop support in there. I'm half in the middle of porting ip_masq_icq,
> but it's one hideously ugly kludge after another. Such is life.

That option seems to conflict with "ipfwadm (2.0-style) support".
Preferably, I'd like to stay with friendly old ipfwadm rather than
switching firewalling tools _again_.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
