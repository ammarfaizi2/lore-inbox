Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbQKBW6I>; Thu, 2 Nov 2000 17:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbQKBW56>; Thu, 2 Nov 2000 17:57:58 -0500
Received: from ppp-97-124-an04u-dada6.iunet.it ([151.35.97.124]:11014 "HELO
	home.bogus") by vger.kernel.org with SMTP id <S129285AbQKBW5o>;
	Thu, 2 Nov 2000 17:57:44 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Date: Fri, 3 Nov 2000 01:12:16 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.21.0011010122160.18143-100000@elte.hu> <3A01ECD2.76DE10FF@timpanogas.org> <3A01EED6.DB47198A@timpanogas.org>
In-Reply-To: <3A01EED6.DB47198A@timpanogas.org>
MIME-Version: 1.0
Message-Id: <00110301140700.00398@linux1.home.bogus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2000, Jeff V. Merkey wrote:
> "Jeff V. Merkey" wrote:
> This code fragment will generate an AGI condition:
> 
> mov   eax, addr
> mov   [eax].offset, ebx

I had already posted the correction.
It was clear that You had forgot something coz Your old code fragment did not
generate AGI.


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
