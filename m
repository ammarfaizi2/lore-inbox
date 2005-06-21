Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVFUPpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVFUPpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVFUPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:44:31 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41466 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262135AbVFUPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:43:20 -0400
Date: Tue, 21 Jun 2005 08:43:15 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621084315.A19881@cox.net>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42B831B4.9020603@pobox.com>; from jgarzik@pobox.com on Tue, Jun 21, 2005 at 11:26:44AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 11:26:44AM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> > rapidio-*
> > 
> >     Will merge.
> 
> send through netdev, as is proper

rapidio-support-net-driver.patch is the only netdev portion.

-Matt
