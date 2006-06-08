Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWFHKC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWFHKC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWFHKC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:02:29 -0400
Received: from ln-bas07.csfb.com ([198.240.128.80]:55759 "EHLO
	ln-bas07.csfb.com") by vger.kernel.org with ESMTP id S932083AbWFHKC3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:02:29 -0400
X-Server-Uuid: 165E975C-7232-48D8-830F-4D7C4151EC0D
X-Server-Uuid: 06A57587-6271-491B-B987-7A9E948E4A38
Message-ID: <F444CAE5E62A714C9F45AA292785BED30EB9719C@esng11p33001.sg.csfb.com>
From: "Majumder, Rajib" <rajib.majumder@credit-suisse.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: binary portability
Date: Thu, 8 Jun 2006 18:01:38 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
X-WSS-ID: 68992A1326O525777-01-01
X-WSS-ID: 68992A23108391105-01-03
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have some binaries built on a RHEL 3/EM64T platform. Can I directly port them to an RHEL 3/AMD64 platform and run without any issue? 

I know that EM64T and AMD64 are ISA compatible, but there could be some differences in ELF32 between these 2 processor architectures. 

Any input will be appreciated. 

Thanks

Rajib  


==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================

