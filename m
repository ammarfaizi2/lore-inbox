Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292353AbSBBTLD>; Sat, 2 Feb 2002 14:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292354AbSBBTKw>; Sat, 2 Feb 2002 14:10:52 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:23954 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292353AbSBBTKn>; Sat, 2 Feb 2002 14:10:43 -0500
Date: Sat, 2 Feb 2002 20:10:26 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: Jens Axboe <axboe@suse.de>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Message-ID: <20020202191026.GA18068@neon>
In-Reply-To: <20020201153303.A1508@prester.hh59.org> <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk> <20020201164813.GA14296@neon> <20020202102659.L12156@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020202102659.L12156@suse.de>
User-Agent: Mutt/1.3.27i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe schrieb am Samstag, den 02. Februar 2002:

> Please try with this patch -- it's against 2.5.3-pre3, but I think it
> should apply to 2.5.3 final as well.

Yes, it did apply against 2.5.3 without a problem and it fixed my errors
which came up in a row in 10sec intervals. Now it seems faster again as
well, so there must have been some slowdown caused by them.

Thanks a lot and best regards,
Axel Siebenwirth
