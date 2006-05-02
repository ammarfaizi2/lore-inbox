Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWEBW0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWEBW0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWEBW0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:26:03 -0400
Received: from mailhost.terra.es ([213.4.149.12]:30451 "EHLO
	csmtpout4.frontal.correo") by vger.kernel.org with ESMTP
	id S964939AbWEBW0C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:26:02 -0400
Date: Wed, 3 May 2006 00:25:13 +0200
From: Diego Calleja <unixforever@terra.es>
To: Avi Kivity <avi@argo.co.il>
Cc: willy@w.ods.org, davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-Id: <20060503002513.1ec1a145.unixforever@terra.es>
In-Reply-To: <44576F8B.7000206@argo.co.il>
References: <161717d50605011046p4bd51bbp760a46da4f1e3379@mail.gmail.com>
	<MDEHLPKNGKAHNMBLJOLKEEGCLKAB.davids@webmaster.com>
	<20060502051238.GB11191@w.ods.org>
	<44573525.7040507@argo.co.il>
	<20060502132139.GA16647@w.ods.org>
	<44576F8B.7000206@argo.co.il>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 02 May 2006 17:41:15 +0300,
Avi Kivity <avi@argo.co.il> escribió:

> I've yet to find a language that combines low level access, efficiency, 
> cleanliness, and expressive power.

In case someone is interested, the freebsd people is trying to design
something that tries to achieve such things for the particular case
of the kernel without falling in the dangers of c++ 

"...a dialect of the C language that simplifies the task of writing kernel
code. It should include language extensions that make it possible to write
kernel code more cleanly and with less bugs. An example of this would have
language support for linked lists, to obviate the need for messy MACROs"

http://wikitest.freebsd.org/moin.cgi/K
