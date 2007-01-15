Return-Path: <linux-kernel-owner+w=401wt.eu-S932237AbXAOLfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbXAOLfN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbXAOLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:35:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55111 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932237AbXAOLfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:35:12 -0500
Subject: Re: 2.6.20-rc4-mm1: status of sn9c102_pas202bca?
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <20070113072718.GI7469@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <20070113072718.GI7469@stusta.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 15 Jan 2007 09:34:34 -0200
Message-Id: <1168860874.5387.1.camel@areia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Em Sáb, 2007-01-13 às 08:27 +0100, Adrian Bunk escreveu: 
> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.20-rc3-mm1:
> >...
> >  git-dvb.patch
> >...
> >  git trees
> >...
> 
> drivers/media/video/sn9c102/sn9c102_pas202bca.c is no longer used or 
> built but still shipped.

Ok, fixed and folded at the original patch. It should be at the next
git-dvb.patch, after Andrew updates it from my tree.

> cu
> Adrian
> 

