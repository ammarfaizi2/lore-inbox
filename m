Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbTJMJ0D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTJMJ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:26:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42202 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261614AbTJMJ0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:26:00 -0400
Date: Mon, 13 Oct 2003 11:25:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Q: how to set dma for device on ide-scsi?
Message-ID: <20031013092556.GK1107@suse.de>
References: <20031013075829.GA14464@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013075829.GA14464@hazard.jcu.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13 2003, Jan Marek wrote:
> Hallo l-k,
> 
> I have one question: how I can set dma mode for CD recorder in the
> ide-scsi emulation mode?
> 
> Hdparm demand work with /dev/sr0 or /dev/sg0... :-(

use the real device

-- 
Jens Axboe

