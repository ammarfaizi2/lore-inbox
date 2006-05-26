Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWEZL0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWEZL0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWEZL0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:26:43 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:18956 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932282AbWEZL0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:26:43 -0400
Date: Fri, 26 May 2006 13:26:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux cbon <linuxcbon@yahoo.fr>, linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060526112636.GA92241@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux cbon <linuxcbon@yahoo.fr>, linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605232338.54177.dhazelton@enter.net> <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com> <200605240017.45039.dhazelton@enter.net> <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 03:14:24PM +1000, Dave Airlie wrote:
> Step 1: add a layer between fbdev and DRM so that they can see each other.

Maybe a stupid question, but what do they need to talk about in
practice?  What should be shared/communicated about in a first time?

  OG.
