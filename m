Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSIKArL>; Tue, 10 Sep 2002 20:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSIKArL>; Tue, 10 Sep 2002 20:47:11 -0400
Received: from mx1.verat.net ([217.26.64.139]:28129 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id <S318243AbSIKArL>;
	Tue, 10 Sep 2002 20:47:11 -0400
From: snpe <snpe@snpe.co.yu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE status
Date: Wed, 11 Sep 2002 03:12:41 +0200
User-Agent: KMail/1.4.6
References: <1031705145.2768.15.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031705145.2768.15.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200209110312.41293.snpe@snpe.co.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool
Kernel release ?
On Wednesday 11 September 2002 02:45 am, Alan Cox wrote:
> Ok the last -ac seems to have worked better than I had expected. I've
> now got the test code with some more PCI cleanups. I need to finish
> pushing these to the other drivers in the PCI layer and then I'll put
> out another release
>
> You can now do
>
> hdparm -t /dev/hda           (get 900K/sec)
> insmod piix
> hdparm -d 1 /dev/hda
> hdparm -t /dev/hda           (get 8Mbyte/sec)
>
> [Yeah my TP600 drive isnt the fastest on earth]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

