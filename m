Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUJTPGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUJTPGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUJTPCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:02:44 -0400
Received: from webapps.arcom.com ([194.200.159.168]:15 "EHLO webapps.arcom.com")
	by vger.kernel.org with ESMTP id S267656AbUJTO7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:59:45 -0400
Subject: Re: Module compilation
From: Ian Campbell <icampbell@arcom.com>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1098284383.29412.1741.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 15:59:44 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2004 14:59:56.0937 (UTC) FILETIME=[76A97790:01C4B6B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 15:36, Richard B. Johnson wrote:

> Could whomever remade the kernel Makefile, please add
> a variable, initially set to "", like CFLAGS_KERNEL, that
> is exported and is always included on the compiler command-
> line?

Does the existing EXTRA_CFLAGS do what you want?

I believe you can also set CFLAGS_blah.o if you just want extra stuff
for a single file.

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

