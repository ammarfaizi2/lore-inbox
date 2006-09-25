Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWIYITJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWIYITJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWIYITJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 04:19:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62394 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750706AbWIYITH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 04:19:07 -0400
Subject: Re: [S390] remove old z90crypt driver.
From: David Woodhouse <dwmw2@infradead.org>
To: schwidefsky@de.ibm.com
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1159171883.28115.2.camel@localhost>
References: <200609222101.k8ML1w93019317@hera.kernel.org>
	 <1159131115.24527.956.camel@pmac.infradead.org>
	 <1159171883.28115.2.camel@localhost>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 09:18:40 +0100
Message-Id: <1159172320.320.5.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-25 at 10:11 +0200, Martin Schwidefsky wrote:
> Unfortunately true. The patches for the new crypto driver originate from
> before headers_install. I forgot to update them accordingly ..
> Anyway, thanks for the heads up. I'll add the patch to git390.  

It's in Linus' tree already.

-- 
dwmw2

