Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281844AbRK1CNO>; Tue, 27 Nov 2001 21:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281831AbRK1CNF>; Tue, 27 Nov 2001 21:13:05 -0500
Received: from mail120.mail.bellsouth.net ([205.152.58.80]:8801 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281844AbRK1CMo>; Tue, 27 Nov 2001 21:12:44 -0500
Message-ID: <3C044816.D6DCD2D3@mandrakesoft.com>
Date: Tue, 27 Nov 2001 21:12:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] earlier printk output
In-Reply-To: <20011127180342.A3921@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> This patch creates console devices specifically for use during early
> boot, and registers them so that printk() output may be seen prior
> to console_init().

> Included are i386 config options, early VGA text output, and early i386
> serial output.

nice.  these patches work on some non-x86 platforms too...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

