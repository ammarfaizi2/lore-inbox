Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSFJWnn>; Mon, 10 Jun 2002 18:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFJWnm>; Mon, 10 Jun 2002 18:43:42 -0400
Received: from [129.46.51.58] ([129.46.51.58]:12706 "EHLO numenor.qualcomm.com")
	by vger.kernel.org with ESMTP id <S316491AbSFJWnl>;
	Mon, 10 Jun 2002 18:43:41 -0400
Message-Id: <5.1.0.14.2.20020610154140.090ec8c8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 10 Jun 2002 15:42:47 -0700
To: Neil Booth <neil@daikokuya.demon.co.uk>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020610215116.GA13380@daikokuya.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>__FUNCTION__ itself will stay forever.
Ok. Then it's not an issue. We should just fix macros that do concatenation.

Thanks
Max

