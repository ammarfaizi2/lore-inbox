Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266882AbRGQRrk>; Tue, 17 Jul 2001 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266883AbRGQRrb>; Tue, 17 Jul 2001 13:47:31 -0400
Received: from winnie.kiasoft.com ([216.254.112.212]:61573 "HELO kiasoft.com")
	by vger.kernel.org with SMTP id <S266882AbRGQRrT>;
	Tue, 17 Jul 2001 13:47:19 -0400
Message-ID: <20010717174520.20893.qmail@kiasoft.com>
From: "Matt DeLoera" <kernel@lambdamat.com>
To: linux-kernel@vger.kernel.org
Subject: PCI-X support?
Date: Tue, 17 Jul 2001 17:45:20 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to understand how to specifically support PCI-X hardware in my
driver.

Code-wise, do I treat a PCI-X device the same as a PCI device in my
hardware detection routine, or are there additional things I need to do?

If anyone could point me to some example code, it'd probably answer all my
questions.

Thanks!
- Matt DeLoera
