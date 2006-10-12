Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWJLT2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWJLT2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWJLT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:28:23 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:5793 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S1750795AbWJLT2X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:28:23 -0400
Date: Thu, 12 Oct 2006 21:28:09 +0200 (MEST)
From: Olaf Hering <olaf@aepfle.de>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mike Galbraith <efault@gmx.de>, Alex Romosan <romosan@sycorax.lbl.gov>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012165901.GA27526@aepfle.de>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061012122146.GS6515@kernel.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, Jens Axboe wrote:

> Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> think it should fix it.

Current Linus tree detects the DVD again on my G5.
