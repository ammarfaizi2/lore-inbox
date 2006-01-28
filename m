Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWA1SIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWA1SIn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWA1SIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:08:43 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13003 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751606AbWA1SIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:08:42 -0500
Subject: Re: I/O Scheduling
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Libin Varghese <libinv@gmail.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20060128185453.12fcd0e6@mango.fruits.de>
References: <43DB405E.4020602@gmail.com>
	 <20060128185453.12fcd0e6@mango.fruits.de>
Content-Type: text/plain
Date: Sat, 28 Jan 2006 13:08:39 -0500
Message-Id: <1138471719.2799.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-28 at 18:54 +0100, Florian Schmidt wrote:
> 
> i'm also interested in these. Especially I/O priorities per
> process/task similar to scheduling priorities. It would be just
> awesome to be able to give i.e. a hd recording program (or any other
> data aquisition or playback program) a high I/O priority.
> 

I believe it's already implemented for the CFQ scheduler only, but the
patch does not seem to be in mainline.

Jens, what's the status of this?

Lee

