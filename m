Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268199AbRGWLNW>; Mon, 23 Jul 2001 07:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268198AbRGWLNM>; Mon, 23 Jul 2001 07:13:12 -0400
Received: from [212.17.18.2] ([212.17.18.2]:9732 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S268197AbRGWLM4> convert rfc822-to-8bit;
	Mon, 23 Jul 2001 07:12:56 -0400
Message-Id: <200107231113.f6NBDmq16388@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Stepan Kalichkin <step@ac-sw.com>
Organization: NGTS
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with configure VMWare modules with 2.4.7 kernel
Date: Mon, 23 Jul 2001 18:13:35 +0700
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <97074884879@vcnet.vc.cvut.cz>
In-Reply-To: <97074884879@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 06:52, you wrote:

> You can download vmmon which works with 2.4.7 from
> ftp://platan.vc.cvut.cz/pub/vmware/vmmon-for-2.4.7-only.tar.gz.
> ~20 line patch is available in VMware newsgroups. This vmmon
> works only with 2.4.7-pre9 and newer kernels, as I was lazy to
> add check for KERNEL_VERSION(2,4,7).
>                                         Best regards,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>
> P.S.: And if you are using bridged networking, do not forget
> download vmnet-204-for-2.4.6.tar.gz too... This fixes oops
> caused by another 2.4.x change.

Thank you for detail answer
It's realy works now!
