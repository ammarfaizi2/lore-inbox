Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbTDBM1L>; Wed, 2 Apr 2003 07:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262984AbTDBM1L>; Wed, 2 Apr 2003 07:27:11 -0500
Received: from [81.2.110.254] ([81.2.110.254]:37361 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S262983AbTDBM1L>;
	Wed, 2 Apr 2003 07:27:11 -0500
Subject: Re: [2.4.21-pre7] Missing PCI-IDs for Intel 82801[DE]B
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Beat Bolli <bbolli@ymail.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000b01c2f89a$d5eb12c0$020ba8c0@bolli>
References: <000b01c2f89a$d5eb12c0$020ba8c0@bolli>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049283603.16275.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2003 12:40:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 23:05, Beat Bolli wrote:
> Hi!
> 
> After pulling the very fresh -pre7 from bk, I get the following errors in
> drivers/ide/pci/piix.c:

Marcelo's tree contains half of the patches I sent so far. I guess he's
still merging the others

