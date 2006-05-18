Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWERPmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWERPmS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWERPmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:42:18 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:57030 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751096AbWERPmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:42:17 -0400
Date: Thu, 18 May 2006 11:42:15 -0400
To: grundig <grundig@teleline.es>
Cc: Felipe Alfaro Solana <felipe.alfaro@gmail.com>, jesper.juhl@gmail.com,
       linuxcbon@yahoo.fr, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060518154215.GG23933@csclub.uwaterloo.ca>
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu> <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com> <9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com> <6f6293f10605171017y106565ev62683f04b353a2f5@mail.gmail.com> <20060517194438.1df682aa.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517194438.1df682aa.grundig@teleline.es>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 07:33:57PM +0200, grundig wrote:
> Windows XP and 2003 support headless mode. I don't think it's particulary
> difficult to do it, just implement a /dev/null graphics driver.
> 
> Oh BTW, Windows is getting their graphics subsystem out of the kernel
> (except the drivers of course) in Vista. The perfect time for people
> to start useless rants on whether Linux should include a graphic subsystem
> in the kernel. 

Wasn't it back in NT4 they moved it into kernel space to speed things
up? :)

Len Sorensen
