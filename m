Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264928AbUF1Mc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbUF1Mc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUF1Mc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:32:26 -0400
Received: from web90101.mail.scd.yahoo.com ([66.218.94.72]:61006 "HELO
	web90101.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264928AbUF1McV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:32:21 -0400
Message-ID: <20040628123220.83361.qmail@web90101.mail.scd.yahoo.com>
Date: Mon, 28 Jun 2004 05:32:20 -0700 (PDT)
From: Deshpande M <pdspartan@yahoo.com>
Subject: Re: Kernel freezes- Init process in console driver
To: Ben Dooks <ben@fluff.org.uk>
Cc: Ben Dooks <ben@mail.home.fluff.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040628122210.GB890@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ben. I'll try this .


--- Ben Dooks <ben@fluff.org.uk> wrote:
> On Mon, Jun 28, 2004 at 05:09:50AM -0700, Deshpande
> M wrote:
> > I tried with 2.6.4 but the result is same. 
> 
> 2.6.6 (iirc) is the first to carry all the arm
> modifications
> as standard. It is best to try the latest version
> before asking
> questions, just in case the problem has been fixed.
> 
> If you are still having problems, check the code
> producing
> the ticks for the system, and check the serial code
> is working.
> 
> -- 
> Ben (ben@fluff.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
