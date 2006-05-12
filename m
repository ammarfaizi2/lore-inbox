Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWELBbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWELBbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 21:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWELBbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 21:31:24 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:20884 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750738AbWELBbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 21:31:23 -0400
Date: Thu, 11 May 2006 22:34:05 -0300
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH 0/2] usbserial: Two minor fixes.
Message-ID: <20060511223405.6fa7a2ae@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Greg,

 These problems are very hard to happen, but I think I've hit the first
one.

[PATCH 1/2] usbserial: Fixes use-after-free in serial_open()
[PATCH 2/2] usbserial: Fixes leak in serial_open() error path


-- 
Luiz Fernando N. Capitulino
