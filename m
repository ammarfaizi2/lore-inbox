Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUHBTBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUHBTBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHBTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:01:11 -0400
Received: from smtp02.ya.com ([62.151.11.161]:25234 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S261857AbUHBTBC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:01:02 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: LKML <linux-kernel@vger.kernel.org>
Subject: USB troubles in rc2
Date: Mon, 2 Aug 2004 21:00:54 +0200
User-Agent: KMail/1.6.82
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408022100.54850.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I have a nforce2 motherboard. I have to report that recent changes in usb 
code make my board don't work at all.

	In 2.6.7-mm7, I just reverted the bk-usb.patch and the things started to 
work, but now it's on mainstream, so I cannot make it work.

	Do you want for me to do some tests?

Thanks.

P.S.: Please, CC me as I'm not subscribed.

-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain
