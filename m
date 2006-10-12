Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWJLUU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWJLUU3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWJLUU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:20:29 -0400
Received: from brick.kernel.dk ([62.242.22.158]:54087 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750851AbWJLUU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:20:29 -0400
Date: Thu, 12 Oct 2006 22:20:41 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Mike Galbraith <efault@gmx.de>, Alex Romosan <romosan@sycorax.lbl.gov>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012202041.GQ6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk> <20061012165901.GA27526@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012165901.GA27526@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Olaf Hering wrote:
> On Thu, Oct 12, Jens Axboe wrote:
> 
> > Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> > think it should fix it.
> 
> Current Linus tree detects the DVD again on my G5.

Super, so it was the same bug as expected. Thanks for retesting.

-- 
Jens Axboe

