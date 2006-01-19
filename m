Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWASLOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWASLOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWASLOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:14:08 -0500
Received: from isilmar.linta.de ([213.239.214.66]:60350 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1161095AbWASLOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:14:07 -0500
Date: Thu, 19 Jan 2006 12:14:04 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] make pcmcia_release_{io,irq} static
Message-ID: <20060119111404.GA2039@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060118005053.118f1abc.akpm@osdl.org> <20060119010536.GU19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119010536.GU19398@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 02:05:36AM +0100, Adrian Bunk wrote:
> On Wed, Jan 18, 2006 at 12:50:53AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm4:
> >...
> >  git-pcmcia.patch
> >...
> >  git trees
> >...
> 
> 
> We can now make pcmcia_release_{io,irq} static.

Applied, thanks.

	Dominik
