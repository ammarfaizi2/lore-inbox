Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279571AbRJXTKw>; Wed, 24 Oct 2001 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRJXTKn>; Wed, 24 Oct 2001 15:10:43 -0400
Received: from mail307.mail.bellsouth.net ([205.152.58.167]:19811 "EHLO
	imf07bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278720AbRJXTK1>; Wed, 24 Oct 2001 15:10:27 -0400
Subject: linux-2.4.12-ac6 and radeonfb-0.1.1
From: Louis Garcia <louisg00@bellsouth.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 24 Oct 2001 15:12:12 -0400
Message-Id: <1003950748.1787.10.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just compiled 2.4.12-ac6 and noticed while booting that the screen was
not scrolling. I saw the penguin but when the text got to the end of the
screen it stopped. The system continued to boot and the screen recovered
when SysV started. I think the problem is only with kernel messages.
This did not happen with 0.1.0.

My card is: ATI Radeon QD DDR 32 MB

Louis


