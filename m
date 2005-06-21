Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVFUIet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVFUIet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVFUIbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:31:08 -0400
Received: from router.nmskb.cz ([82.142.73.249]:40842 "EHLO smtp.nmskb.cz")
	by vger.kernel.org with ESMTP id S262075AbVFUI3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:29:46 -0400
Date: Tue, 21 Jun 2005 10:29:21 +0200
From: Feyd <feyd@nmskb.cz>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Jirka Bohac <jbohac@suse.cz>, Denis Vlasenko <vda@ilport.com.ua>,
       Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050621102921.5a8c953a@alfa.nmskb.cz>
In-Reply-To: <42B7C4D0.9070809@thekelleys.org.uk>
References: <20050608142310.GA2339@elf.ucw.cz>
	<200506081744.20687.vda@ilport.com.ua>
	<20050608145653.GA8844@dwarf.suse.cz>
	<42B7C4D0.9070809@thekelleys.org.uk>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; i686-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 08:42:08 +0100
Simon Kelley <simon@thekelleys.org.uk> wrote:

> The atmel driver includes a small firmware stub which does nothing but 
> determine the MAC address, to solve this problem. This is compiled into 

Does it power-down the card after reading the MAC?

Feyd
