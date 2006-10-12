Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWJLNG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWJLNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWJLNG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:06:58 -0400
Received: from brick.kernel.dk ([62.242.22.158]:32071 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751077AbWJLNG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:06:58 -0400
Date: Thu, 12 Oct 2006 15:07:07 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012130707.GY6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk> <1160648885.5897.6.camel@Homer.simpson.net> <1160662435.6177.3.camel@Homer.simpson.net> <20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk> <1160664290.6207.2.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160664290.6207.2.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12 2006, Mike Galbraith wrote:
> On Thu, 2006-10-12 at 14:21 +0200, Jens Axboe wrote:
> 
> > Mike/Alex/Olaf, can you give this a spin? Totally untested here, but I
> > think it should fix it.
> 
> Yup, all better here.  Thanks.

Ah that's great, I'll add the patch for inclusion soon.

-- 
Jens Axboe

