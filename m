Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUKONjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUKONjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 08:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUKONjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 08:39:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54472 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261594AbUKONjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 08:39:47 -0500
Date: Mon, 15 Nov 2004 08:38:32 -0500
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Red Hat <alan@redhat.com>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI atp870u.c: make a needlessly global function static
Message-ID: <20041115133832.GC3964@devserv.devel.redhat.com>
References: <20041115015430.GF2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115015430.GF2249@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 02:54:30AM +0100, Adrian Bunk wrote:
> The patch below makes the function is870 which has no external users 
> static.

ACK. Makes total sense
