Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVDEPrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVDEPrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVDEPqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:46:24 -0400
Received: from smtp12.wanadoo.fr ([193.252.22.20]:34272 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S261788AbVDEPnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:43:24 -0400
X-ME-UUID: 20050405154315815.C71031C000B5@mwinf1204.wanadoo.fr
Date: Tue, 5 Apr 2005 17:39:52 +0200
To: Josselin Mouette <joss@debian.org>
Cc: Adrian Bunk <bunk@stusta.de>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405153952.GA26672@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404190518.GA17087@wonderland.linux.it> <20050404193204.GD4087@stusta.de> <1112709907.30856.17.camel@silicium.ccc.cea.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112709907.30856.17.camel@silicium.ccc.cea.fr>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 04:05:07PM +0200, Josselin Mouette wrote:
> Le lundi 04 avril 2005 à 21:32 +0200, Adrian Bunk a écrit :
> > On Mon, Apr 04, 2005 at 09:05:18PM +0200, Marco d'Itri wrote:
> > > On Apr 04, Greg KH <greg@kroah.com> wrote:
> > > 
> > > > What if we don't want to do so?  I know I personally posted a solution
> > > Then probably the extremists in Debian will manage to kill your driver,
> > > like they did with tg3 and others.
> > 
> > And as they are doing with e.g. the complete gcc documentation.
> > 
> > No documentation for the C compiler (not even a documentation of the 
> > options) will be neither fun for the users of Debian nor for the Debian 
> > maintainers - but it's the future of Debian...
> 
> You are mixing apples and oranges. The fact that the GFDL sucks has
> nothing to do with the firmware issue. With the current situation of
> firmwares in the kernel, it is illegal to redistribute binary images of
> the kernel. Full stop. End of story. Bye bye. Redhat and SuSE may still
> be willing to distribute such binary images, but it isn't our problem.
> 
> Putting the firmwares outside the kernel makes them distributable. Some
> distributions will want to include them, some others not. But the
> important point is that it makes that redistribution legal.

Nope, in this case, the place where those firmware blobs are found are totally
irelevant, since we reached consensus on debian-legal in marsh that they
constitute mere agregation, where either the file or the elf binary are just
the distribution media.

And those binary blobs currently come under the GPL or are not licenced at
all, so taking them out of the kernel doesn't make them distributable in any
way.

Friendly,

Sven Luther

