Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278408AbRJMUyy>; Sat, 13 Oct 2001 16:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278411AbRJMUyo>; Sat, 13 Oct 2001 16:54:44 -0400
Received: from vitelus.com ([64.81.243.207]:42758 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278408AbRJMUyj>;
	Sat, 13 Oct 2001 16:54:39 -0400
Date: Sat, 13 Oct 2001 13:55:07 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Message-ID: <20011013135507.B9856@vitelus.com>
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 01:05:33PM +0200, peter k. wrote:
> iptables keeps telling me that whenever i run it although i got the latest
> kernel, latest iptables and all modules required for iptables are loaded (it
> also doesnt work when i compile them into the kernel)!
> anyone got an idea how to fix this?

did you compile your iptables against the version/configuration of the
kernel you are trying to run?
