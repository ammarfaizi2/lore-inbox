Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVCROuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVCROuj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCROuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 09:50:39 -0500
Received: from upco.es ([130.206.70.227]:48320 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261619AbVCROub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 09:50:31 -0500
Date: Fri, 18 Mar 2005 15:50:28 +0100
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Maximilian Engelhardt <maxi@daemonizer.de>
Subject: Re: Call for help: list of machines with working S3
Message-ID: <20050318145028.GA22887@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Maximilian Engelhardt <maxi@daemonizer.de>
References: <3xVNA-Qn-43@gated-at.bofh.it> <1111089912.9802.26.camel@mobile>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1111089912.9802.26.camel@mobile>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2005 at 09:05:12PM +0100, Maximilian Engelhardt wrote:
> On Mon, 2005-02-14 at 22:20 +0100, Pavel Machek wrote:

> > 		Video issues with S3 resume
> > 		~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 		  2003-2005, Pavel Machek
> > 

> Tried all this on my Laptop but nothing seems to work for me. 
> I do "echo 3 > /proc/acpi/sleep" and the systems seems to go into S3.
> When I press some key to wake it up again it powers up but I get nothing
> than a black screen. It's not only the video card that's not working,
> because the only thing it reacts to is Sysrq (without screen of course).
> One additional thing I found is that in this state the HDD led keeps
> lighting all the time untill I reboot my system. After rebooting I
> couldn't find anything interesting in my logs.
> 
> Is there any way I could get S3 working on my laptop?
> 
> some data:
> Acer Travel Mate 661lci
> Gentoo Base System version 1.6.10
> kernel 2.6.11
> 
> I did all this testing with a minimal kernel that only had the
> absolutely necessary drivers.

It happens exactly the same on my laptop, sony vaio whose configuration is 

http://www.dea.icai.upco.es/romano/linux/vaio-conf/laptop-config.html

Next week is Easter holyday here, I will try to connect my Psion casio as
serial terminal and see if I can catch something. 

       Romano 
       
       
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
