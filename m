Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVIGXP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVIGXP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 19:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVIGXP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 19:15:28 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53468 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932476AbVIGXP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 19:15:27 -0400
Date: Wed, 7 Sep 2005 16:15:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][MM] cleanup rionet and use updated rio message interface
Message-ID: <20050907161526.F1925@cox.net>
References: <20050907081751.C1925@cox.net> <20050907154444.4f38462d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050907154444.4f38462d.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 07, 2005 at 03:44:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 03:44:44PM -0700, Andrew Morton wrote:
> Matt Porter <mporter@kernel.crashing.org> wrote:
> >
> > This is the rionet cleanup patch previously posted in reply to Jeff's
> > concerns with this driver. It depends on the rapidio messaging interface
> > updates patch. 
> 
> Thanks.  So are there any outstanding issues with the rapidio patches?

There are no outstanding issues raised on the base subsystem. There are
issues with the lack of features implemented, however. ;) Myself and
others are working on some enhancements for new silicon, MMIO, etc.

Jeff's comments on the rionet driver were the only remaining issues on
the current patches.  Hopefully he can ack/nack these updates to rionet.

-Matt
