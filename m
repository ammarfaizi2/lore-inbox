Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269512AbTHFPps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTHFPpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:45:47 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:64004 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S269557AbTHFPpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:45:47 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: arjanv@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: any DRM update scheduled for 2.4.23-pre?
Date: Wed, 6 Aug 2003 17:44:58 +0200
User-Agent: KMail/1.5.3
Cc: Mikael Pettersson <mikpe@csd.uu.se>, faith@valinux.com,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Mitch@0Bits.COM
References: <16177.5641.6571.273023@gargle.gargle.HOWL> <200308061714.36595.m.c.p@wolk-project.de> <1060184267.5848.6.camel@laptop.fenrus.com>
In-Reply-To: <1060184267.5848.6.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308061743.46570.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 17:37, Arjan van de Ven wrote:

Hi Arjan,

> > It's a complete DRM-4.3 tree. He has to decide between an update of
> > existing 4.2 code or an addition of a new subdirectory drm-4.3 + proper
> > config.in entry.
> did you clean the tree up like in -ac's tree or did you take it as is
> from some cvs repo ?
nope, cvs. If Alan will be so kind to send me the fixes he made and I don't 
have to do the double-work, I'll integrate and test them up.

Or another choice would be that Alan will send his drm 4.3 code to Marcelo 
once .22 final is out for .23-pre1 inclusion.

Decide yourself :)

ciao, Marc

