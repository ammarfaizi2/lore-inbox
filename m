Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264797AbTE1QZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264794AbTE1QZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 12:25:33 -0400
Received: from [65.248.4.67] ([65.248.4.67]:33985 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S264797AbTE1QZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 12:25:31 -0400
Message-ID: <000601c32537$54582e40$58dea7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Get pages
Date: Wed, 28 May 2003 13:36:45 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

How can i get all the pages of a zone ?

I think i can use
pgd_offset(mm,address)+pmd_offset(pgd,address)+pte_offset(pmd,address)+pte_p
age() , and "address" could be physical address of a page , can be ?

thanks
Breno

