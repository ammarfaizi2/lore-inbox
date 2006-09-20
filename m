Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWISXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWISXhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWISXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 19:37:15 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48836 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750804AbWISXhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 19:37:13 -0400
Subject: Re: [PATCH] Adds kernel parameter to ignore pci devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <8b96e3d20609191518o3a6d4ee3j7e3e40a72260a8af@mail.gmail.com>
References: <8b96e3d20609191447x77e284b1j904e4106942e040e@mail.gmail.com>
	 <8b96e3d20609191518o3a6d4ee3j7e3e40a72260a8af@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 01:01:12 +0100
Message-Id: <1158710473.32598.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure its the way I'd approach it - in your specific case it should
be easier to just not compile in EHCI (USB 2.0) support.


