Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUAHTya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 14:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUAHTvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 14:51:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:31121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266320AbUAHTtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 14:49:40 -0500
Date: Thu, 8 Jan 2004 11:46:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Howto use diff compatibly
Message-Id: <20040108114648.0eeb8da9.rddunlap@osdl.org>
In-Reply-To: <200401081436.15006.gene.heskett@verizon.net>
References: <200401081436.15006.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004 14:36:15 -0500 Gene Heskett <gene.heskett@verizon.net> wrote:

| Greetings;
| 
| Whats the general option syntax used with diff to generate the 
| patchfiles I see posted here?
| 
| I have a small patch to drivers/block/floppy.c that seems to allow it 
| to function with older 256 byte per sector formats that I'd like to 
| submit.

Please read Documentation/SubmittingPatches .

--
~Randy
MOTD:  Always include version info.
