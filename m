Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266931AbSKURYG>; Thu, 21 Nov 2002 12:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbSKURYG>; Thu, 21 Nov 2002 12:24:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266931AbSKURYG>;
	Thu, 21 Nov 2002 12:24:06 -0500
Message-ID: <3DDD185C.9080803@pobox.com>
Date: Thu, 21 Nov 2002 12:31:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: Robert Olsson <Robert.Olsson@data.slu.se>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
References: <15835.56316.564937.169193@robur.slu.se> <20021120164319.A26918@vger.timpanogas.org> <15836.47295.808423.41648@robur.slu.se> <20021121111010.A31363@vger.timpanogas.org> <15835.56316.564937.169193@robur.slu.se> <3DDD141F.4010402@pobox.com> <20021121113042.A31516@vger.timpanogas.org>
In-Reply-To: <15835.56316.564937.169193@robur.slu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> >NAPI poll does not happen in an interrupt.  Doing things in interrupts
> >is the source of problems that NAPI is trying to solve.
> >
> >Other than that, please read the code and NAPI paper...  :)
>
>
>
>
> Where can I find it?



In the link Robert Ollson gave to you (paper), and the Linux kernel (code).

	Jeff



