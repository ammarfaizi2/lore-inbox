Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269490AbRHAF4g>; Wed, 1 Aug 2001 01:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269654AbRHAF43>; Wed, 1 Aug 2001 01:56:29 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:24324 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S269490AbRHAF4S>; Wed, 1 Aug 2001 01:56:18 -0400
Date: Tue, 31 Jul 2001 20:25:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Nigel Bennington <nigel-home@corleco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken source file in v2.4.7 sources
Message-ID: <20010731202511.A1953@suse.de>
In-Reply-To: <NPEEKFLGNDBMBALCMAHGAEBBCBAA.nigel-home@corleco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NPEEKFLGNDBMBALCMAHGAEBBCBAA.nigel-home@corleco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31 2001, Nigel Bennington wrote:
> Hi, I hope I've addressed this bug report to the right people...
> 
> In the sources for v2.4.7, as current yesterday (30/Jun/2001), the file
> 
> drivers/block/DAC960.c
> 
> refers to the sem member of a variable defined as being of type IO_Request_T

Use 2.4.8-pre3, or whatever is latest now. The DAC960 breakage is known
and fixed.

-- 
Jens Axboe

