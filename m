Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVAMQsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVAMQsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVAMQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:46:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:36580 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261231AbVAMQqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:46:00 -0500
Subject: Re: RAIT device driver feasibility
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E696F4.3070700@linbox.com>
References: <41E696F4.3070700@linbox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105630888.4664.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 15:41:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 15:42, Ludovic Drolez wrote:
> RAIT already exists in Amanda, in user space, but I'd like to see a generic 
> kernel RAIT driver which could be used by any backup program.

Why kernel space - why not a user space shared library you can add to
other tape apps?

