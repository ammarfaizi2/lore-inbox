Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbTIPA7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbTIPA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 20:59:21 -0400
Received: from [65.248.4.67] ([65.248.4.67]:53189 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261707AbTIPA7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 20:59:20 -0400
Message-ID: <000c01c37bed$6890ede0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Unresolved symbol
Date: Mon, 15 Sep 2003 21:56:47 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

I tried to compile kernel 2.4.18 on amd athlon , but i received teh message
:

unresolved symbol __mmx_memcpy

EXPORT_SYMBOL(__mmx_memcpy) in ksyms.c can fix this ?

att,
Breno

