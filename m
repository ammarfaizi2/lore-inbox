Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWHGPVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWHGPVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWHGPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:21:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48072 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932149AbWHGPVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:21:02 -0400
Subject: Re: [patch] s390: xpram system device class.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060807150639.GD10416@skybase>
References: <20060807150639.GD10416@skybase>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Aug 2006 16:40:50 +0100
Message-Id: <1154965250.25998.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-07 am 17:06 +0200, ysgrifennodd Martin Schwidefsky:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [S390] xpram system device class.
> 
> Remove system device class for xpram. 
> 

This seems to have various other changes in it - switches to atomic
operations and the like which aren't explained..

