Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265576AbRF1HTQ>; Thu, 28 Jun 2001 03:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbRF1HTG>; Thu, 28 Jun 2001 03:19:06 -0400
Received: from t2.redhat.com ([199.183.24.243]:18159 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265576AbRF1HS7>; Thu, 28 Jun 2001 03:18:59 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3B3A4967.CD5A83BA@mandrakesoft.com> 
In-Reply-To: <3B3A4967.CD5A83BA@mandrakesoft.com>  <Pine.LNX.4.33.0106271348420.24832-100000@penguin.transmeta.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.6.5: fix mtd config 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 08:18:47 +0100
Message-ID: <13913.993712727@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
> Seeing David Woodhouse's name reminds me that this patch, submitted by
> both David and myself, didn't make it into pre5...  It moves
> mtd-related config items inside CONFIG_MTD. 

Jeff, thankyou for finding this and making me aware of it. It's now in the 
2.4.6 branch of my tree and I'll resend it, along with one or two other 
minor fixes, shortly. I'll now need to wait to see whether this partial 
patch appears in -pre6, I suppose.

--
dwmw2


