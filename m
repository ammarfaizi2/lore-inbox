Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWHIOQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWHIOQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWHIOQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:16:25 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38538 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750870AbWHIOQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:16:24 -0400
Subject: Re: Marvell PATA IDE Controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060809134249.GE2959@mail.muni.cz>
References: <20060809113650.GA2959@mail.muni.cz>
	 <1155127850.5729.164.camel@localhost.localdomain>
	 <20060809134249.GE2959@mail.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 15:36:26 +0100
Message-Id: <1155134187.5729.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 15:42 +0200, ysgrifennodd Lukas Hejtmanek:
> And is there something I could do? At least make it working as generic PCI IDE
> like windows?

You can try booting with the option all-generic-ide. Should get you
minimal functionality with luck.

