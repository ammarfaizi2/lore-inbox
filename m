Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270045AbTGSMym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 08:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270048AbTGSMym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 08:54:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16859
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270045AbTGSMym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 08:54:42 -0400
Subject: Re: 2.6.0-test1: Framebuffer problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0307190801260.26815-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307190801260.26815-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058620026.22005.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Jul 2003 14:07:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-19 at 07:02, Geert Uytterhoeven wrote:
> No, that's not so simple, because vesafb requests the linear frame buffer,
> while vga16fb requests the VGA region.

In standard usage mode both of them use the vga registers for palette control..


