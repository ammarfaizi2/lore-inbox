Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292643AbSBZSUW>; Tue, 26 Feb 2002 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSBZSTz>; Tue, 26 Feb 2002 13:19:55 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:21443 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S292654AbSBZSTD>; Tue, 26 Feb 2002 13:19:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: wwp <subscript@free.fr>
Subject: Re: low latency & preemtible kernels
Date: Tue, 26 Feb 2002 19:18:52 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200202261918.53190.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wwp wrote:
> Hi there,
>
> here's a newbie question:
> is it UNadvisable to apply both preempt-kernel-rml and low-latency patches
> over a 2.4.18 kernel?

In short: no ;-)

Try 2.4.18-rc4-jam2 for example. It should apply against 2.4.18 final, too.


Regards,
	Dieter
