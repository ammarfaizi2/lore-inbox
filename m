Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288882AbSAUXGq>; Mon, 21 Jan 2002 18:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288917AbSAUXGg>; Mon, 21 Jan 2002 18:06:36 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:56204 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288882AbSAUXG1>;
	Mon, 21 Jan 2002 18:06:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Giacomo Catenazzi <cate@dplanet.ch>
Subject: Re: [kbuild-devel] Re: CML2-2.1.3 is available
Date: Tue, 22 Jan 2002 00:11:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20020115145324.A5772@thyrsus.com> <E16ShDP-0001ic-00@starship.berlin> <3C4C4A60.7030700@dplanet.ch>
In-Reply-To: <3C4C4A60.7030700@dplanet.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Snav-0001kl-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 21, 2002 06:05 pm, Giacomo Catenazzi wrote:
> Daniel Phillips wrote:
> 
> > 
> > I detect a slight lack of symmetry here, shouldn't it be "make
> > autoconfig"? Pardon me if this has been beaten to^W^W discussed above.
> 
> 
> Yes. It should be "make autoconfig", for symmterty reasons :-)
> I called the files and the project autoconfigure, because
> 'autoconfig' is already an utility made by GNU. (not related
> to kernel)

This is kernel autoconfig, different namespace, same idea.  I don't think you 
have a problem.  Besides, last time I checked, autoconfig wasn't copyrighted.

--
Daniel
