Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVEQTZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVEQTZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVEQTZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:25:43 -0400
Received: from 4.34.76.83.cust.bluewin.ch ([83.76.34.4]:53574 "EHLO
	kestrel.twibright.com") by vger.kernel.org with ESMTP
	id S261553AbVEQTZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:25:37 -0400
Date: Tue, 17 May 2005 21:22:09 +0200
From: Karel Kulhavy <clock@twibright.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs doesn't work even with docbook stylesheets installed
Message-ID: <20050517192209.GB19373@kestrel.twibright.com>
References: <20050512120358.GA8126@kestrel> <20050512212918.GA3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512212918.GA3603@stusta.de>
X-Orientation: Gay
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >       Size of downloaded files: 1,514 kB
> >       Homepage:    http://docbook.sourceforge.net/
> >       Description: XSL Stylesheets for Docbook
> >       License:     || ( as-is BSD )
> > 
> > Is this a bug in Linux make htmldocs?
> 
> 
> It sounds more like you are missing a package.
> 
> In Debian it's called "docbook-utils", I don't know whether it has the 
> same name in Gentoo.

gentoo doesn't have docbook-utils. How do I compile linux kernel
documentations on gentoo?

And btw why doesn't README or the error message that docbook-utils
package is required? I suggest that this be added into README together
with the docbook stylesheets (and the information which one of the 2
stylesheets are meant).

CL<
