Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbSKSTMR>; Tue, 19 Nov 2002 14:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbSKSTMR>; Tue, 19 Nov 2002 14:12:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:51896 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267148AbSKSTMI>; Tue, 19 Nov 2002 14:12:08 -0500
Subject: Re: [TRIVIAL PATCH 2.5.48] Remove unused function from radeon_mem.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bob Miller <rem@osdl.org>
Cc: trivial@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021119185015.GG1986@doc.pdx.osdl.net>
References: <20021119185015.GG1986@doc.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Nov 2002 19:47:13 +0000
Message-Id: <1037735233.12086.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you leave this one. Its just going to make resynching with the
XFree86 4.3 DRM harder. The DRM in the kernel is about to become
obsolete anyway

