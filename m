Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVCLVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVCLVPA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVCLVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 16:15:00 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:54419 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261358AbVCLVOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 16:14:52 -0500
Date: Sat, 12 Mar 2005 22:15:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Romain Lievin <lkml@lievin.net>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Fix warning in gkc (make gconfig) {Scanned}
Message-ID: <20050312211558.GA18623@mars.ravnborg.org>
Mail-Followup-To: Romain Lievin <lkml@lievin.net>,
	linux-kernel@vger.kernel.org, zippel@linux-m68k.org
References: <20050309083612.GA15812@lievin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309083612.GA15812@lievin.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 09:36:12AM +0100, Romain Lievin wrote:
> Hi,
> 
> this patch against 2.6.11-rc3 fixes some warnings about GtkToolButton in gkc
> (the GTK Kernel Configurator).

Applied, 2 warnings fixed - 10 more to go.
Care to take a look at them?
Also gconfig does not support setting localversion - is this something you
can fix too?

	Sam
