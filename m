Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135810AbRAUHoc>; Sun, 21 Jan 2001 02:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135809AbRAUHoV>; Sun, 21 Jan 2001 02:44:21 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:34964 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S135806AbRAUHoG>; Sun, 21 Jan 2001 02:44:06 -0500
Date: Sun, 21 Jan 2001 07:47:30 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Daniel Stone <daniel@kabuki.eyep.net>
cc: Aaron Lehmann <aaronl@vitelus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 and ipmasq modules
In-Reply-To: <E14K7UY-0004hB-00@kabuki.eyep.net>
Message-ID: <Pine.LNX.4.31.0101210746410.1046-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jan 2001, Daniel Stone wrote:

> FTP is under Connection Tracking support, FTP connection tracking. Does
> the same stuff as ip_masq_ftp. IRC is located in patch-o-matic -
> download iptables 1.2 and do a make patch-o-matic, there is also RPC and
> eggdrop support in there. I'm half in the middle of porting ip_masq_icq,
> but it's one hideously ugly kludge after another. Such is life.
>

uhmm... ICQ seems to work fine through connection tracking for me, so
is there a need for a special ip_masq_icq module?

> d

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
[We] use bad software and bad machines for the wrong things.
		-- R.W. Hamming

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
