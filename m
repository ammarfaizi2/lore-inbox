Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbTJFNwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTJFNwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:52:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58777 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262108AbTJFNwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:52:51 -0400
Date: Mon, 6 Oct 2003 15:52:46 +0200
From: Jens Axboe <axboe@suse.de>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check copy_from_user return value in sony535
Message-ID: <20031006135245.GB972@suse.de>
References: <3F8173EA.7040802@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8173EA.7040802@terra.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06 2003, Felipe W Damasio wrote:
> 	Hi Jens,
> 
> 	Patch against 2.6.0-test6.
> 
> 	- Check the return value of copy_from_user on sony535 CDROM driver. 
> Found by smatch.

Looks fine, thanks.

> 	Following the local style, btw :)

Appreciated :)

-- 
Jens Axboe

