Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDTIjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDTIjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWDTIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:39:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750706AbWDTIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:39:31 -0400
Subject: Re: Verify Kernel Pointer
From: Arjan van de Ven <arjan@infradead.org>
To: Talib Alim <talibalm@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY22-F8A1F03E25EB82978C6B06DDBA0@phx.gbl>
References: <BAY22-F8A1F03E25EB82978C6B06DDBA0@phx.gbl>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 10:39:25 +0200
Message-Id: <1145522365.3023.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 03:33 +0000, Talib Alim wrote:
> A kernel virtual address is passed to my module.

that sounds like a design bug (if the "passed to" is from userspace)
>  In order to avoid any 
> chances of a crash, how can I verify  this pointer is pointing to a mapped 
> memory location.

given your design bug, I would suggest you post the URL to your code so
that we can help you fix your design instead...

