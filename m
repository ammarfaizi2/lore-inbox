Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132565AbRDHPRF>; Sun, 8 Apr 2001 11:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132570AbRDHPQ4>; Sun, 8 Apr 2001 11:16:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132568AbRDHPQn>;
	Sun, 8 Apr 2001 11:16:43 -0400
Date: Sun, 8 Apr 2001 16:16:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Marvin Stodolsky <stodolsk@rcn.com>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: build -->/usr/src/linux
Message-ID: <20010408161620.A21660@flint.arm.linux.org.uk>
In-Reply-To: <3AD079EA.50DA97F3@rcn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AD079EA.50DA97F3@rcn.com>; from stodolsk@rcn.com on Sun, Apr 08, 2001 at 09:47:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 09:47:06AM -0500, Marvin Stodolsky wrote:
> It's presence has required some gymnastics, per below, during module
> installation for the Winmodem driver, ltmodem.o requiring a subsequent
> "depmod -a"

You need to update your modutils package - there have been a number of
important bug fixes, including some which allow it to work properly with
2.4 kernels.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

