Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264927AbRF3KMv>; Sat, 30 Jun 2001 06:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbRF3KMm>; Sat, 30 Jun 2001 06:12:42 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:4106 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S264927AbRF3KM3>; Sat, 30 Jun 2001 06:12:29 -0400
Date: Sat, 30 Jun 2001 12:05:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, andre@aslab.com, Gunther.Mayer@t-online.de,
        dhinds@zen.stanford.edu, linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)
Message-ID: <20010630120524.A7832@suse.de>
In-Reply-To: <UTC200106280105.DAA331227.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200106280105.DAA331227.aeb@vlet.cwi.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28 2001, Andries.Brouwer@cwi.nl wrote:
> Why precisely is complying to SFF-8020 broken?

Because 8020 is _old and dated_, yet some manufacturers still base new
devices on it. That is what is broken, clearly noone is faulting a '96
device for being based on SFF-8020, however a '09 and '01 is a different
story.

> You are a good disciple of Hale, but it is no use ignoring the

:-)

-- 
Jens Axboe
