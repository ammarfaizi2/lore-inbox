Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266148AbUGEQhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266148AbUGEQhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 12:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUGEQhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 12:37:04 -0400
Received: from sarajevo.idealx.com ([213.41.87.90]:44995 "EHLO
	sarajevo.idealx.com") by vger.kernel.org with ESMTP id S266148AbUGEQhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 12:37:02 -0400
From: =?iso-8859-1?q?S=E9bastien_BOMBAL?= <sbombal@idealx.com>
Organization: IDEALX
To: linux-kernel@vger.kernel.org
Subject: Question about the role of macros _IO
Date: Mon, 5 Jul 2004 18:30:46 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407051830.46060.sbombal@idealx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody,

I have a question about the purpose of macros _IO, _IOR, _IOW, _IORW. I saw in 
the 2.6 code that they are used sometimes for IOCTL to group them. Is it 
the only purpose ?

Thanks for your help.

Regards.

-- 
Sébastien BOMBAL


