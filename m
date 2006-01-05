Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752251AbWAEWo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbWAEWo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbWAEWo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:44:56 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:17051 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1752249AbWAEWoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:44:55 -0500
Date: Thu, 5 Jan 2006 15:44:55 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] scsi_transport_spi.c: make print_nego() static
Message-ID: <20060105224455.GY19769@parisc-linux.org>
References: <20060105223918.GM12313@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105223918.GM12313@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:39:18PM +0100, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

Sure,  makes  sense.   Thanks.
