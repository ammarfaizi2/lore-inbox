Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVDEOCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVDEOCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVDEOCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:02:52 -0400
Received: from heavensgate.debian.net ([213.41.173.23]:5517 "EHLO
	heavensgate.debian.net") by vger.kernel.org with ESMTP
	id S261739AbVDEOCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:02:46 -0400
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
	copyright notice.
From: Josselin Mouette <joss@debian.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050404193204.GD4087@stusta.de>
References: <20050404100929.GA23921@pegasos>
	 <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos>
	 <20050404175130.GA11257@kroah.com>
	 <20050404190518.GA17087@wonderland.linux.it>
	 <20050404193204.GD4087@stusta.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 05 Apr 2005 16:05:07 +0200
Message-Id: <1112709907.30856.17.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 04 avril 2005 à 21:32 +0200, Adrian Bunk a écrit :
> On Mon, Apr 04, 2005 at 09:05:18PM +0200, Marco d'Itri wrote:
> > On Apr 04, Greg KH <greg@kroah.com> wrote:
> > 
> > > What if we don't want to do so?  I know I personally posted a solution
> > Then probably the extremists in Debian will manage to kill your driver,
> > like they did with tg3 and others.
> 
> And as they are doing with e.g. the complete gcc documentation.
> 
> No documentation for the C compiler (not even a documentation of the 
> options) will be neither fun for the users of Debian nor for the Debian 
> maintainers - but it's the future of Debian...

You are mixing apples and oranges. The fact that the GFDL sucks has
nothing to do with the firmware issue. With the current situation of
firmwares in the kernel, it is illegal to redistribute binary images of
the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
be willing to distribute such binary images, but it isn't our problem.

Putting the firmwares outside the kernel makes them distributable. Some
distributions will want to include them, some others not. But the
important point is that it makes that redistribution legal.
-- 
 .''`.           Josselin Mouette        /\./\
: :' :           josselin.mouette@ens-lyon.org
`. `'                        joss@debian.org
   `-  Debian GNU/Linux -- The power of freedom

