Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUGIP43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUGIP43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUGIP43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:56:29 -0400
Received: from [193.12.224.70] ([193.12.224.70]:42485 "EHLO defiant")
	by vger.kernel.org with ESMTP id S264973AbUGIP42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:56:28 -0400
Date: Fri, 9 Jul 2004 17:56:14 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsusp bootsplash support
Message-ID: <20040709155614.GA8426@linux.nu>
Reply-To: erik@rigtorp.com
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org> <20040708204840.GB607@openzaurus.ucw.cz> <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz> <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz> <20040709115531.GA28343@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709115531.GA28343@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 12:55:31PM +0100, Dave Jones wrote:
> Personally I'd prefer the effort went into making suspend actually
> work on more machines rather than painting eyecandy for the minority
> of machines it currently works on.

Miniority? Well both swsusp and pmdisk has worked on the majority of
machines I've come across. From what I understand swsusp works on almost all
x86 uniprocessor machines and that's a lot of machines. Some drivers are a
hassle though. 

Erik
