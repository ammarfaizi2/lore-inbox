Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSHWLGx>; Fri, 23 Aug 2002 07:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSHWLGw>; Fri, 23 Aug 2002 07:06:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:30993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318752AbSHWLGw>; Fri, 23 Aug 2002 07:06:52 -0400
Date: Fri, 23 Aug 2002 12:10:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, jgarzik@mandrakesoft.com,
       ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020823121059.D20963@flint.arm.linux.org.uk>
References: <200208230654.XAA02328@adam.yggdrasil.com> <Pine.LNX.4.10.10208230022060.14761-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10208230022060.14761-100000@master.linux-ide.org>; from andre@linux-ide.org on Fri, Aug 23, 2002 at 12:45:03AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 12:45:03AM -0700, Andre Hedrick wrote:
> This is where JG's hard work and my time with him explaining it will help
> most.  Also case where RMK's ARM toys do fun things and the assumption by
> the driver that POST is valid is DEAD WRONG.  I will repeat the assumption
> of my code about POST is DEAD WRONG!  POST like events happen at different
> times for various archs.

Yet more FUD.  Andre - go away and come back once you've calmed down.

Maybe its because you don't actually understand my IDE hardware.  I
dunno.  But you are "DEAD WRONG" about the crap you've written above.

Completely.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

