Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUHJMv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUHJMv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUHJMuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:50:19 -0400
Received: from [213.146.154.40] ([213.146.154.40]:62180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264917AbUHJMqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:46:47 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: James.Bottomley@steeleye.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       eric@lammerts.org, linux-kernel@vger.kernel.org
In-Reply-To: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de>
References: <200408101027.i7AARuZr012065@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092141996.4383.8119.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 10 Aug 2004 13:46:36 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 12:27 +0200, Joerg Schilling wrote:
> Please inform yourself before posting.....

Jrg, you are making a fool of yourself.

> Burn-Proof is switched off by default and other protections (invented later)
> are switched off by cdrecord to get compatibility..... if you only had read the 
> man page......
> 
> Switching Burn-Proof on will reduce the quality of the CDs.

I haven't even stated which distribution I'm running. How can you
possibly know what it puts into /etc/cdrecord.conf when it detects my
CD-R? What relation has this to your man page?

> In addition: if you don't have the experience when Buffer Underruns occur, you 
> should not post speculations that it is not a problem.

I have experience that buffer underruns do not occur, when I am not
running as root. Therefore I posted a statement that running as root is
not strictly necessary. What part of that do you not understand?

>  I know that it _is_ and this should be enough for you. Unless you
> send me the results from a test done under worst conditions you need
> to believe in the experience of people who spend more time on CD/DVD
> recording issues than you.

Perhaps I should. But I think that in the last few days you've managed
to lose even the shred of credibility you once had. I shall now take
anything you say with an _extremely_ large pinch of salt.

> Jrg

-- 
dwmw2

