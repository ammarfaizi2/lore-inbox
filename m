Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273261AbRJJF62>; Wed, 10 Oct 2001 01:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJJF6L>; Wed, 10 Oct 2001 01:58:11 -0400
Received: from h226-58.adirondack.albany.edu ([169.226.226.58]:27588 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S273261AbRJJF5x>;
	Wed, 10 Oct 2001 01:57:53 -0400
Date: Wed, 10 Oct 2001 01:25:00 -0400
From: Justin A <justin@bouncybouncy.net>
To: safemode <safemode@speakeasy.net>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010012500.A6551@bouncybouncy.net>
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010003636Z271005-760+23005@vger.kernel.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 08:36:56PM -0400, safemode wrote:
> Heavily io bound processes (dbench 32)  still causes something as light as an 
> mp3 player to skip, though.   That probably wont be fixed intil 2.5, since 

What buffer size are you using in your mp3 player?  I have xmms set to
5000ms or so and it never skips.  mpg321(esd or oss) also never skips no
matter what I do, but the original mpg123-oss will with even light load
on the cpu/disk.

This is with 2.4.10-ac9+preempt on an athlon 700

-Justin
