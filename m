Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278435AbRJMWxJ>; Sat, 13 Oct 2001 18:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278436AbRJMWwx>; Sat, 13 Oct 2001 18:52:53 -0400
Received: from vitelus.com ([64.81.243.207]:21511 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278435AbRJMWw3>;
	Sat, 13 Oct 2001 18:52:29 -0400
Date: Sat, 13 Oct 2001 15:52:59 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [solved] iptables v1.2.3: can't initialize iptables table `filter': Module is wrong version
Message-ID: <20011013155259.F9856@vitelus.com>
In-Reply-To: <004801c153d6$ffc398c0$0100005a@host1> <20011013135507.B9856@vitelus.com> <00ea01c15430$345a96c0$303fe33e@host1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ea01c15430$345a96c0$303fe33e@host1>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 11:44:14PM +0200, peter k. wrote:
> did that, now it works! :)
> seems like it doesnt work if i use the iptables from the mandrake rpm

I'm somewhat upset about this. Rusty, what's up? I have to recompile
the deb against my kernel configuration for it to not myseriously
complain.
