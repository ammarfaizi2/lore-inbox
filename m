Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTIPPJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTIPPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:09:27 -0400
Received: from [65.248.4.67] ([65.248.4.67]:58594 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261939AbTIPPJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:09:25 -0400
Message-ID: <000e01c37c64$257b0960$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Robert Love" <rml@tech9.net>
Cc: "Kernel List" <linux-kernel@vger.kernel.org>
References: <000b01c37af0$402349a0$f8e4a7c8@bsb.virtua.com.br> <1063566718.24473.63.camel@localhost>
Subject: Memory allocation
Date: Tue, 16 Sep 2003 12:04:46 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When i use kmem_cache_alloc() to create a vma and return addr of this vma ,
the pages have already been allocated and mapped ?  or i must use
mk_pte/set_pte to map the page to my vma ?

att
Breno

