Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278697AbRJSX5c>; Fri, 19 Oct 2001 19:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278698AbRJSX5W>; Fri, 19 Oct 2001 19:57:22 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:50888 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278697AbRJSX5E>; Fri, 19 Oct 2001 19:57:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [RFC] New Driver Model for 2.5
Date: Sat, 20 Oct 2001 01:54:22 +0200
Message-Id: <20011019235422.22016@smtp.wanadoo.fr>
In-Reply-To: <20011019233026.30554@smtp.wanadoo.fr>
In-Reply-To: <20011019233026.30554@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Reading about the suspend to disk issue, and thinking about
>some of my needs, I tend to stil think we have overlooked
>that issue. We should probably add a couple of list_heads
>to define a second tree in parallell to the device-tree, which
>is the power tree. A device is by default inserted in both
>tree as a child of it's bus controller. But the arch must be
>able to move it elsewhere. I beleive we have a way around the
>VM related ordering issues, but we do have other kind of
>ordering constraints. 
>
> .../...

Argh, I'm too tired, I sent the draft ! sorry ;)

Ben.


