Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbRHBMAn>; Thu, 2 Aug 2001 08:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRHBMAd>; Thu, 2 Aug 2001 08:00:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268902AbRHBMA2>;
	Thu, 2 Aug 2001 08:00:28 -0400
Date: Thu, 2 Aug 2001 13:00:35 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrey Panin <pazke@orbita1.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move SIIG parallel/serial combo cards to parport-serial.c
Message-ID: <20010802130035.A29643@flint.arm.linux.org.uk>
In-Reply-To: <20010802155331.A6072@orbita1.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010802155331.A6072@orbita1.ru>; from pazke@orbita1.ru on Thu, Aug 02, 2001 at 03:53:31PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 03:53:31PM +0400, Andrey Panin wrote:
> attached patch moves SIIG serial/parallel combo card support from
> serail and parport_pc drivers to parport_serial.

Please CC: me with any comments on this patch.

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

