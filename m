Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRJMQz3>; Sat, 13 Oct 2001 12:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278334AbRJMQzS>; Sat, 13 Oct 2001 12:55:18 -0400
Received: from ms1.adiis.net ([207.177.36.3]:725 "EHLO ms1.adiis.net")
	by vger.kernel.org with ESMTP id <S276477AbRJMQzM>;
	Sat, 13 Oct 2001 12:55:12 -0400
Subject: Re: System won't reboot from Linux?
From: Ryan Butler <rbutler@adiis.net>
To: Ian Morgan <imorgan@webcon.net>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110130043460.5298-100000@light.webcon.net>
In-Reply-To: <Pine.LNX.4.40.0110130043460.5298-100000@light.webcon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 13 Oct 2001 11:56:07 -0500
Message-Id: <1002992168.14465.2.camel@hoi-dsl-cust33.adiis.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-12 at 23:53, Ian Morgan wrote:
> On Fri, 12 Oct 2001, Mark Hahn wrote:
> 
> > > Linux, but refuses to reboot. i.e. gets to the end of the shutdown scripts,
> > > says "Restarting system", then just hangs.
> >
> > have you looked at the reboot= kernel parameter?
> 
> Thanks for the pointer, but it doesn't seem to have helped.
> I've tried every reboot= parameter ([wc],[bh]), and still no luck...
> 
> Regards,
> Ian Morgan


Ian:

Please have a look at the kernel thread dealing with Compaq 16xx and
APM.

This sounds like the same problem, but I'd like your thoughts on the
thread and whether it applies to other laptops than just compaq.


-- 
Ryan Butler
ADI Internet Solutions
rbutler@adiis.net
Work:  641-753-8080
 Fax:  641-753-7779


