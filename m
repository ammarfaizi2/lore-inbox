Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbVHIAaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVHIAaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHIAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:30:19 -0400
Received: from dsl017-059-136.wdc2.dsl.speakeasy.net ([69.17.59.136]:31876
	"EHLO luther.kurtwerks.com") by vger.kernel.org with ESMTP
	id S932385AbVHIAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:30:18 -0400
Date: Mon, 8 Aug 2005 20:31:40 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Removing maintainer's bad e-mails
Message-ID: <20050809003140.GJ7667@kurtwerks.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42F69E53.40602@gmail.com> <20050808183300.GB26182@redhat.com> <20050808224917.GP4006@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808224917.GP4006@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.12.3
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 12:49:17AM +0200, Adrian Bunk took 42 lines to write:
> On Mon, Aug 08, 2005 at 02:33:00PM -0400, Dave Jones wrote:
> > 
> > You may as well change the S: to unmaintained whilst
> > you're there, it hasn't seen any updates in a long time,
> > and still uses several out-of-date SCSI APIs.
> 
> Or he could completely remove the entry.
> 
> We don't have entries for every single unmaintained driver, and the 
> smaller MAINTAINERS is the higher is the possibility of not missing a 
> relevant entry when checking whom to send an email.

Hmm, so if a subsystem or driver (more drivers, I should think) lacks
an entry in MAINTAINERS, is it then reasonable to assume that it is
unmaintained? If not, perhaps creating a separate list of unmaintained
subsystems and/or drivers is prudent?

Kurt
-- 
Don't get even -- get odd!
