Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWHCMwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWHCMwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWHCMwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:52:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38854 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932428AbWHCMwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:52:54 -0400
Subject: Re: [PATCH] tty_io.c: keep davej sane
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060802230210.GB6825@martell.zuzino.mipt.ru>
References: <20060802223604.GI3639@redhat.com>
	 <20060802223733.GA20485@redhat.com>
	 <20060802230210.GB6825@martell.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 14:12:03 +0100
Message-Id: <1154610723.23655.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 03:02 +0400, ysgrifennodd Alexey Dobriyan:
> Just comment and next "while" look _very_ wrong. Place { correctly to
> hint unsuspecting ones that it's the end of the loop actually.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>


