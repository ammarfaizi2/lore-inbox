Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKUOpK>; Tue, 21 Nov 2000 09:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbQKUOpA>; Tue, 21 Nov 2000 09:45:00 -0500
Received: from mail1.digital.com ([204.123.2.50]:54799 "EHLO mail1.digital.com")
	by vger.kernel.org with ESMTP id <S129412AbQKUOot>;
	Tue, 21 Nov 2000 09:44:49 -0500
From: jg@pa.dec.com (Jim Gettys)
Date: Tue, 21 Nov 2000 06:14:42 -0800 (PST)
Message-Id: <200011211414.eALEEgj112604@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: Dennis Noordsij <dennis.noordsij@wiral.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <00112116072601.01134@dennis>
Subject: Re: Framebuffer orientation
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The right place to ask is "xpert@xfree86.org".

The answer is that if performance is not a major issue, implementing
this for a given graphics card is now pretty easy, using the shadow
frame buffer code.

For straight frame buffers, the TinyX server will now do this "out of the
box".
					- Jim

> Sender: linux-kernel-owner@vger.kernel.org
> From: Dennis Noordsij <dennis.noordsij@wiral.com>
> Date: 	Tue, 21 Nov 2000 16:07:26 +0200
> To: linux-kernel@vger.kernel.org
> Subject: Framebuffer orientation
> -----
> Hi,
> 
> Is there any way to use the framebuffer on the i386 architecture in a
> 'portrait' way? I am using a QBE web tablet and it favours the screen in that
> position. (768x1024).
> 
> I know X can do it for a few videocards, but not this one :-)
> 
> 
> Regards,
> Dennis
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
