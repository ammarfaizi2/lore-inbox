Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284204AbRLTLYG>; Thu, 20 Dec 2001 06:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284199AbRLTLX5>; Thu, 20 Dec 2001 06:23:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19475 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284181AbRLTLXm>;
	Thu, 20 Dec 2001 06:23:42 -0500
Date: Thu, 20 Dec 2001 12:23:25 +0100
From: Jens Axboe <axboe@suse.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220122325.A710@suse.de>
In-Reply-To: <20011220111249.GA15692@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011220111249.GA15692@wizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
> 
>         Hate to be an old bugger and bring this up again, but I just had this 
> old problem show up again, with 2.5.1-dj3. The scoop:

Were you using sr or ide-cd when this happened? There seems to be stuff
missing from the kernel messages you included, could you please check
dmesg for all of it.

Don't worry, it's no shocker if eject isn't working :-)

-- 
Jens Axboe

