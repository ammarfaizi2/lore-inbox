Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268346AbUH0Vkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268346AbUH0Vkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267638AbUH0Vj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:39:27 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:58345 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268553AbUH0Vfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:35:30 -0400
Subject: Re: pwc+pwcx is not illegal
From: Albert Cahalan <albert@users.sf.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       nemosoft@smcc.demon.nl, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <412F8CDD.7030107@grupopie.com>
References: <1093634283.431.6370.camel@cube> <412F8CDD.7030107@grupopie.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093642476.431.6540.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Aug 2004 17:34:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 15:34, Paulo Marques wrote:
> Albert Cahalan wrote:
> > Paulo Marques writes:

> >>About the legal aspects of all this, they have been
> >>discussed extensively in the past. It is not about
> >>"hey this is just a simple hook", it is all about
> >>the derived work concept. This driver does absolutely
> >>nothing outside the kernel. It's only purpose is to
> >>attach itself to the kernel and to provide the images
> >>from the camera to userspace using the kernel ABI's.
> >>So you can not say it is not a derived work at all.
> > 
> > 
> > (note: the following is not legal advice)
> > 
> > I think you'll find that this is not supported by
> > the copyright law, at least in the United States and
> > in any sane country.
> > 
> > Richard Stallman and The SCO Group might like your
> > interpretation, at least when it serves them, but
> > that doesn't make it the law.
> 
> You're completely missing the point. I never said that the pwcx driver 
> copies code from the kernel, and in doing so infringes copyright law.
> 
> What I'm saying is that the kernel is distributed with a license that 
> allows you certain rights, and that extending the kernel functionality 
> through closed source drivers is not one of those rights.

True, but misleading.

The GPL is not an EULA contract that makes you give
up your right to extend kernel functionality.
The GPL doesn't grant you the right to read the code,
but nobody complains that code reading is prohibited.
Such activities are outside the scope of the GPL.

> It is a derived work, not a "copied" work. The point is:
> 
>  >>This driver does absolutely
>  >>nothing outside the kernel. It's only purpose is to
>  >>attach itself to the kernel and to provide the images
>  >>from the camera to userspace using the kernel ABI's.

Whatever. I don't see how that matters.

To be a derived work, some protectable element of
the kernel would have to be included. That might be
limited to lines of code, or it might include some
higher-level features like control flow. Either way,
the pwcx driver won't qualify as being derived.

The SCO Group has a better chance than you do. :-)
(and, if you're right, BAD things happen)


