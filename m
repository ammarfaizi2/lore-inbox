Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266421AbTGESsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbTGESsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 14:48:33 -0400
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:386 "EHLO
	ori.thedillows.org") by vger.kernel.org with ESMTP id S266421AbTGESsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 14:48:32 -0400
Subject: Re: Linux - 3Com 3CR990 driver
From: David Dillow <dave@thedillows.org>
To: smiler@lanil.mine.nu
Cc: yogesh@unipune.ernet.in, linux-kernel@vger.kernel.org
In-Reply-To: <1057402216.2295.46.camel@sm-wks1.lan.irkk.nu>
References: <32995.196.1.114.224.1057226672.squirrel@unipune.ernet.in>
	 <1057402216.2295.46.camel@sm-wks1.lan.irkk.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057431767.2707.1.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jul 2003 15:02:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

3cr990 series is supported in 2.4.21+, and 2.5.something+

It still does not do crypto offload - new job, little time, blah blah
blah.. :(

On Sat, 2003-07-05 at 06:50, Christian Axelsson wrote:
> On Thu, 2003-07-03 at 12:04, Yogesh Subhash Talekar wrote:
> > Hello,
> > 
> > Firstly sorry for such an unexpected distrurbance. But I saw your posts on
> > Linux kernel lists which raised my hopes and hence this mail.
> > 
> > We at University of Pune, India run the campus network whose backbone runs
> > on OFC. We decided to upgrade it to 100 mbps from 10mbps and bought 3COM
> > 3CR990 cards to install them in 20 Linux servers we have.
> > 
> > Now that has landed us in big trouble. The driver which 3COM provided on
> > CD-ROMs is not working. Also the one we downloaded from 3COM's website is
> > also not working.
> > 
> > Whenever we make the cards up and try to check simple FTP speeds from one
> > machine to other it comes to about 800 kbps! We changed the CISCO-2990
> > fiber switch to make sure that it is not because of the faulty switch..
> > but in vein.
> > 
> > We also tried 2.5.X but it fails to compile.
> > 
> > Does anyone of you has a solution / advice/ code?
> > 
> > Please help.....
> > 
> > --yogesh talekar
> 
> Im also very intressed in this since I have a few off these (that works
> like a charm under w2k btw).
> Im CC:ing the LKML, maybe someone has more answers.
