Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRI0JWf>; Thu, 27 Sep 2001 05:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272253AbRI0JWZ>; Thu, 27 Sep 2001 05:22:25 -0400
Received: from hal.grips.com ([62.144.214.40]:53140 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S272242AbRI0JWF>;
	Thu, 27 Sep 2001 05:22:05 -0400
Message-Id: <200109270922.f8R9MSm11333@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: Andrei Lahun <Uman@editec-lotteries.com>, linux-kernel@vger.kernel.org
Subject: Re: proces stopped in D state for a long time(2.4.10)
Date: Thu, 27 Sep 2001 11:22:27 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010927123522.A380@chert.194.133.98.200>
In-Reply-To: <20010927123522.A380@chert.194.133.98.200>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are the lucky one.
dbench 32 results in 32 D state processes for me.
No disk operation is possible afterwards
The reset button is the only way out.

(dbench 24 is ok)

Gerold

On Thursday 27 September 2001 12:35, Andrei Lahun wrote:
> I had a problems with dvd player(xine) with 2.4.10 when i try to search in
> movie on of the xine threads stooped in D state for 10-20 second.
