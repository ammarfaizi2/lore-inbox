Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTHFPRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 11:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTHFPRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 11:17:15 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:59396 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263997AbTHFPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 11:17:14 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Mikael Pettersson <mikpe@csd.uu.se>, faith@valinux.com
Subject: Re: any DRM update scheduled for 2.4.23-pre?
Date: Wed, 6 Aug 2003 17:16:16 +0200
User-Agent: KMail/1.5.3
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Mitch@0Bits.COM
References: <16177.5641.6571.273023@gargle.gargle.HOWL>
In-Reply-To: <16177.5641.6571.273023@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308061714.36595.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 August 2003 16:51, Mikael Pettersson wrote:

Hi Mikael,

> Is anyone planning to update the apparently obsolete(*)
> DRM drivers currently in 2.4.22-pre/rc for 2.4.23?

I have a pending DRM 4.3 update for .23-pre1. Marcelo did not accept it for 
.22 ( I sent it first while -pre9 time or so. )

It's a complete DRM-4.3 tree. He has to decide between an update of existing 
4.2 code or an addition of a new subdirectory drm-4.3 + proper config.in 
entry.

ciao, Marc

