Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbUADROh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265734AbUADROe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:14:34 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:39348 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265711AbUADROd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:14:33 -0500
Date: Sun, 4 Jan 2004 18:14:10 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Rob Love <rml@ximian.com>
Cc: Dave Jones <davej@redhat.com>, Mikael Pettersson <mikpe@csd.uu.se>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104171410.GF24913@louise.pinerecords.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur> <20040104165028.GC31585@redhat.com> <1073235682.5225.12.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073235682.5225.12.camel@fur>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-04 2004, Sun, 12:01 -0500
Rob Love <rml@ximian.com> wrote:

> On Sun, 2004-01-04 at 11:50, Dave Jones wrote:
> 
> > FWIW, I agree with it too on the grounds that its non obvious the optimal
> > setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
> > helptext to read...
> > 
> >  "Pentium II"
> >  "Pentium III / Pentium 4M"
> >  "Pentium 4"
> 
> Oh, very much agreed.  Giving it a separate configure option also opens
> the door for easily adding an march=pentiumm whenever the gcc folks get
> around to adding that.

Yes.  That was the door I was aiming to open. <g>

-- 
Tomas Szepe <szepe@pinerecords.com>
