Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278646AbRKFIRr>; Tue, 6 Nov 2001 03:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRKFIR2>; Tue, 6 Nov 2001 03:17:28 -0500
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:4287 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S278642AbRKFIRZ>; Tue, 6 Nov 2001 03:17:25 -0500
Message-ID: <3BE79B95.50B454F7@cisco.com>
Date: Tue, 06 Nov 2001 13:43:09 +0530
From: Manik Raina <manik@cisco.com>
X-Mailer: Mozilla 4.76 [en]C-CCK-MCD   (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 warnings and errors - M
In-Reply-To: <18970.1005034082@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is fixed. I sent a patch, Alan's applied it already.

Keith Owens wrote:drivers/message/i2o/i2o_block.c: In function `i2ob_install_device':

> drivers/message/i2o/i2o_block.c:1375: warning: comparison is always 0 due to width of bitfield
> drivers/message/i2o/i2o_block.c:1378: warning: comparison is always 0 due to width of bitfield

