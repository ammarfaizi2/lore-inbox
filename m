Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVAUIal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVAUIal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVAUIal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:30:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:48529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262312AbVAUIai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:30:38 -0500
Date: Fri, 21 Jan 2005 00:30:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm2
Message-Id: <20050121003011.155538a5.akpm@osdl.org>
In-Reply-To: <41F0B807.6000606@kolivas.org>
References: <20050119213818.55b14bb0.akpm@osdl.org>
	<41F0B807.6000606@kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
>  Wont boot.
> 
>  Stops after BIOS check successful.

Your config boots OK on my P4.  As per usual :(

>  Tried reverting a couple of patches mentioning boot or reboot and had no 
>  luck. Any ideas?

None whatsoever, sorry.  Guess you could try stripping the .config, see if
you can identify something from that.

Did you try early printk?
