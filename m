Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFNCQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFNCQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFNCQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:16:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2735 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261386AbVFNCP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:15:56 -0400
Date: Tue, 14 Jun 2005 10:19:26 +0800
From: David Teigland <teigland@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Patrick Caulfield <pcaulfie@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/dlm/: make code static
Message-ID: <20050614021926.GA13499@redhat.com>
References: <20050614014325.GC3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614014325.GC3770@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 03:43:26AM +0200, Adrian Bunk wrote:
> This patch makes needlessly global code static.

Thanks, I already applied these changes; just haven't sent off
a new batch of -mm patches yet.

Dave

