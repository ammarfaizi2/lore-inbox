Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWCMN0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWCMN0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWCMN0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:26:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29391 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751054AbWCMN0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:26:53 -0500
Subject: Re: Problem applying Patch to linux 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: swapnil <swapnil@spsoftindia.com>
Cc: "'Jesper Juhl'" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060313132439.9866A32C033@smtpauth00.csee.siteprotect.com>
References: <20060313132439.9866A32C033@smtpauth00.csee.siteprotect.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 14:26:46 +0100
Message-Id: <1142256406.3023.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 18:56 +0530, swapnil wrote:
> Hi Jesper,
> 
> Thanks for your quick reply.
> 
> I have followed the steps suggested by you as follows:
> 
> I have change into the kernel source directory:
> 
> [root@lustdevp 2.6.11-1.1369_FC4-i686]# pwd
> /usr/src/kernels/2.6.11-1.1369_FC4-i686

that isn't even the kernel source, but only the headers!


you should just give up what you're doing, because it's invalid in more
than 5 ways (as per Jespers email) and download the 2.6.16 full tar file
instead.


