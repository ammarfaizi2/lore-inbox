Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbTCKUHh>; Tue, 11 Mar 2003 15:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbTCKUHh>; Tue, 11 Mar 2003 15:07:37 -0500
Received: from host-132.c8b96c.mrconcursos.com.br ([200.185.108.132]:23746
	"EHLO maisbrasil.com.br") by vger.kernel.org with ESMTP
	id <S261608AbTCKUHg>; Tue, 11 Mar 2003 15:07:36 -0500
Message-ID: <004401c2e80a$7e74dc60$c2dea7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Mapping pages
Date: Tue, 11 Mar 2003 17:12:08 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-XTmail: http://www.verdesmares.com davi@verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

people , can i use alloc_page(GFP_KERNEL)+mk_pte()+set_pte()  or
alloc_page(GFP_KERNEL)+kmap()  to alloc and map pages for kernel-space ?


thanks
Breno


