Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279737AbRJ3BsA>; Mon, 29 Oct 2001 20:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279738AbRJ3Bru>; Mon, 29 Oct 2001 20:47:50 -0500
Received: from smtphost.qualcomm.com ([129.46.64.223]:5875 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S279737AbRJ3Brm>; Mon, 29 Oct 2001 20:47:42 -0500
Message-Id: <5.1.0.14.0.20011029174700.08e93090@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 29 Oct 2001 17:48:35 -0800
To: <pcg@goof.com ( Marc A. Lehmann )>, linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: 2.4.13-ac5 && vtun not working
In-Reply-To: <20011030023933.A11774@schmorp.de>
In-Reply-To: <20011030021740.A8708@schmorp.de>
 <20011030021740.A8708@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, Oct 30, 2001 at 02:17:40AM +0100, " Marc A. Lehmann " <pcg@goof.com> wrote:
>> a _lot_ of searching revealed this code fragment:
>
>In my usual attempt to generate more traffic, I forgot to mention that I
>found it in net/core/dev.c ;)
>
>(oh, and after reading the comments int hat file, I think that maybe tun.c
>simply shouldn't call dev_alloc_name...)
Hmm, let me check that. 
I was under the assumption that it's dev.c bug :)

Max

