Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTIIRE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 13:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTIIRDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 13:03:17 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:45977 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S264278AbTIIRDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 13:03:06 -0400
Date: Tue, 9 Sep 2003 10:03:04 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with remap_page_range
Message-ID: <20030909100304.B20267@home.com>
References: <3F5E7ACD.8040106@tait.co.nz> <20030909095926.GA31080@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030909095926.GA31080@mail.jlokier.co.uk>; from jamie@shareable.org on Tue, Sep 09, 2003 at 10:59:26AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 10:59:26AM +0100, Jamie Lokier wrote:
> Dmytro Bablinyuk wrote:
> >  if (remap_page_range(vma->vm_start,
> 
> Try io_remap_page_range() instead?

These are identical on PPC.

-Matt
