Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269507AbUJLIIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269507AbUJLIIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269511AbUJLIIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:08:12 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:12939 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S269507AbUJLIII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:08:08 -0400
Message-ID: <416B90E5.1090201@ribosome.natur.cuni.cz>
Date: Tue, 12 Oct 2004 10:08:05 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040914
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2-6.9-rc4 oops on unmounting usbdev
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I've tried to shutdown machine without unmounting usb digital camera's filesystem.
It has resulted in kernel ooops. Resolved stack trace is at: http://www.natur.cuni.cz/~mmokrejs/269-rc4.jpg.
Do you need more info? Please Cc: me in replies, if possible.
Martin
