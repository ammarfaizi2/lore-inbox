Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUFLKUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUFLKUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 06:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbUFLKUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 06:20:00 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:11100 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264704AbUFLKT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 06:19:59 -0400
Subject: Re: [ANNOUNCE] -ar patchset
From: Redeeman <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040612023928.A103F23C03@ws5-3.us4.outblaze.com>
References: <20040612023928.A103F23C03@ws5-3.us4.outblaze.com>
Content-Type: text/plain
Message-Id: <1087035598.10652.1.camel@redeeman.kaspersandberg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 12 Jun 2004 12:19:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-12 at 04:39, Pokey the Penguin wrote:
> > find the initial version of the patch, with staircase, 
> > autoregulate-swappiness, supermount-ng, ext3 and reiser improvements, and a 
> 
> I gather that supermount-ng is now quite dated and no longer maintained. Is 
> submount (http://submount.sourceforge.net/) not the current favourite to 
> provide such functionality?
> 
> Looking at the two, submount definitely seems more ready for inclusion based 
> on its non-invasive approach.
i believe that having the automounting inside the kernel is a bad idea.
i think there should be more people using HAL and D-BUS, together with a
userspace automounter. like ivman, http://ivman.sf.net

-- 
Regards, Redeeman
redeeman@metanurb.dk

