Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTLDVFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTLDVFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:05:30 -0500
Received: from kuma.unm.edu ([64.106.76.7]:25573 "HELO kuma.unm.edu")
	by vger.kernel.org with SMTP id S263564AbTLDVFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:05:24 -0500
To: redhat-list@redhat.com
Subject: reserving IRQs
Date: Thu, 04 Dec 2003 14:05:19 -0700
From: Daniel Sheltraw <sheltraw@unm.edu>
Cc: linux-kernel@vger.kernel.org
Message-ID: <1070571919.3fcfa18fe4223@webmail3.unm.edu>
References: <1070571737.3fcfa0d93fab2@webmail3.unm.edu>
In-Reply-To: <1070571737.3fcfa0d93fab2@webmail3.unm.edu>
X-Mailer: UNM WebMail v1.1.10 24-January-2003
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 64.106.33.63
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello 
 
I would like to create a mask of usable IRQs for Linux to use. The
Boot-Prompt HowTo at:
 
   http://www.ibiblio.org/mdw/HOWTO/BootPrompt-HOWTO-4.html#ss4.4
 
says one can use pci=irqmask=mask at the lilo boot prompt (or
as an append in /etc/lilo.conf) to accomplish this task.
 
I have not been able to get this mask working for the 2.4.20
kernel. Can anyone help me reserve IRQs? 
 
I would usually do this through BIOS but unfortunately my Dell BIOS
does not provide the usual screen for doing so.
 
Thanks,
Daniel
