Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTIWNIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbTIWNIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:08:43 -0400
Received: from [65.248.4.67] ([65.248.4.67]:60559 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261226AbTIWNIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:08:43 -0400
Message-ID: <000e01c381d3$39cc9fe0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Cc: "Marcelo" <marcelo@conectiva.com.br>
Subject: Just alloc/map memory if have free pages
Date: Tue, 23 Sep 2003 10:04:22 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , i am testing a solution that just alloc and mapping pages for a process
, if there are free pages to do.
Also i have an idea to create a vn management with nice value.


Look the ideia in : www.bandnet.com.br/~breno_silva/Kernel_linux/new_mm.c

att,
Breno



