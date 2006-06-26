Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWFZGjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWFZGjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWFZGjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:39:35 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:50844 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964851AbWFZGje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:39:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bzfXb33WvSRAfM6eoyaaMXy3XNM2zkJ/4tJ4KpUT7AG5XkyDrHlPFQla3cDS+NHkybqb8BUloMhNXsP04rEfeeUxSke/lGB+7jMm4uNC5IlTsb44QUzr/s0DEuLEEwEDW2dbesXqjKWKEoutIVofbaPSFjZUk3yU/IJNOsZuqCo=
Message-ID: <a44ae5cd0606252339v51cada26x6ab23da155e1dea5@mail.gmail.com>
Date: Sun, 25 Jun 2006 23:39:34 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Subject: =?WINDOWS-1252?Q?In_function_=91ioat=5Finit=5Fmodule=92:_2.6.17?= =?WINDOWS-1252?Q?-mm2_--_In_function_=91ioat=5Finit=5Fmodule=92?= =?WINDOWS-1252?Q?:_drivers/dma/ioatdma.c:828:_error:_de?= =?WINDOWS-1252?Q?referencing_pointer_to_incomplete_type?=
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      drivers/dma/ioatdma.o
drivers/dma/ioatdma.c: In function 'ioat_init_module':
drivers/dma/ioatdma.c:828: error: dereferencing pointer to incomplete type
make[2]: *** [drivers/dma/ioatdma.o] Error 1
