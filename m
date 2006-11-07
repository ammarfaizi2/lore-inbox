Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752924AbWKGVKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbWKGVKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752926AbWKGVKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:10:21 -0500
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:12744 "EHLO
	aa011msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1752918AbWKGVKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:10:20 -0500
Date: Tue, 7 Nov 2006 22:10:05 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Robotis Konstantinos" <krobotis@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: write data to a file from a kernel module
Message-ID: <20061107221005.753305e7@localhost>
In-Reply-To: <f356cfa0611070652u75eb5622v2144daa9fa4b563f@mail.gmail.com>
References: <f356cfa0611070652u75eb5622v2144daa9fa4b563f@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 09:52:27 -0500
"Robotis Konstantinos" <krobotis@gmail.com> wrote:

> Hello,
> 
> I am trying to create a module for kernel 2.4.27 that writes data to a
> file when it
> receives a packet from the network interface card.

http://kernelnewbies.org/FAQ/WhyWritingFilesFromKernelIsBad

-- 
	Paolo Ornati
	Linux 2.6.19-rc4-gd1ed6a3e on x86_64
