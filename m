Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267401AbTGWKhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbTGWKgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:36:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10464 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267542AbTGWKgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:36:45 -0400
Date: Wed, 23 Jul 2003 12:51:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, andersen@codepoet.org,
       jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
Message-ID: <20030723105146.GB26422@fs.tum.de>
References: <200307230512.h6N5CXQ10468@adam.yggdrasil.com> <Pine.LNX.4.10.10307222219300.10927-100000@master.linux-ide.org> <20030723090847.GZ26422@fs.tum.de> <1058956149.5520.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058956149.5520.10.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 11:29:10AM +0100, Alan Cox wrote:
> On Mer, 2003-07-23 at 10:08, Adrian Bunk wrote:
> > There are _many_ people that have a copyright on parts of the Linux
> > kernel (the exact number might be different in different countries due
> > to different copyright laws). To change the copyright to anything other
> > than GPL v2 is practically impossible (even if a new version of the GPL
> > might fix the deficits you mentioned).
> 
> v2 or later. The GPL only permits "any version" or "n or later".

Section 9 of the GPL says:

<--  snip  -->

The Free Software Foundation may publish revised and/or new versions of
the General Public License from time to time.  Such new versions will be
similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

Each version is given a distinguishing version number.  If the Program
specifies a version number of this License which applies to it and "any
later version", you have the option of following the terms and
conditions either of that version or of any later version published by
the Free Software Foundation.  If the Program does not specify a version
number of this License, you may choose any version ever published by the
Free Software Foundation.

<--  snip  -->

This implicitely says that if the version of the GPL is specified it's 
fixed.

AFAIR in 2.2 times Linus added the explicit version statement present in
COPYING.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

