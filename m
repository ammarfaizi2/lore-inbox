Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbSKDXxU>; Mon, 4 Nov 2002 18:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263077AbSKDXxU>; Mon, 4 Nov 2002 18:53:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40848 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263039AbSKDXxP>;
	Mon, 4 Nov 2002 18:53:15 -0500
Date: Mon, 04 Nov 2002 15:54:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Wierd error messages from starfire driver 
Message-ID: <1040010000.1036454069@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting these for ever, and they don't seem to
do any harm ... but they're rather worrying, and I'm curious
as to whath they are.

I suspect the "Increasing Tx FIFO threshold" is just being
unnecessarily verbose ... but the "Something Wicked happened!"
error doesn't look too happy ... any clues as to what this is?

Thanks,

Martin.

Increasing Tx FIFO threshold to 80 bytes
eth0: Increasing Tx FIFO threshold to 96 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 112 bytes
eth0: Increasing Tx FIFO threshold to 128 bytes
eth0: Something Wicked happened! 204b101.
eth0: Increasing Tx FIFO threshold to 144 bytes
eth0: Increasing Tx FIFO threshold to 160 bytes
eth0: Something Wicked happened! 2049001.
eth0: Increasing Tx FIFO threshold to 176 bytes
eth0: Increasing Tx FIFO threshold to 192 bytes
eth0: Increasing Tx FIFO threshold to 208 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 224 bytes
eth0: Increasing Tx FIFO threshold to 240 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 256 bytes
eth0: Increasing Tx FIFO threshold to 272 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 288 bytes
eth0: Increasing Tx FIFO threshold to 304 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 320 bytes
eth0: Increasing Tx FIFO threshold to 336 bytes
eth0: Increasing Tx FIFO threshold to 352 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 368 bytes
eth0: Increasing Tx FIFO threshold to 384 bytes
eth0: Increasing Tx FIFO threshold to 400 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 416 bytes
eth0: Increasing Tx FIFO threshold to 432 bytes
eth0: Increasing Tx FIFO threshold to 448 bytes
eth0: Increasing Tx FIFO threshold to 464 bytes
eth0: Something Wicked happened! 2049101.
eth0: Increasing Tx FIFO threshold to 480 bytes
eth0: Increasing Tx FIFO threshold to 496 bytes

