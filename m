Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTGOX7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbTGOX7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:59:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:4434 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S269957AbTGOX66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:58:58 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307160013.h6G0Df906030@devserv.devel.redhat.com>
Subject: Re: [PATCH] (2.4.22-pre6 BK) New (IDE) driver: SGI IOC4
To: jgarzik@pobox.com (Jeff Garzik)
Date: Tue, 15 Jul 2003 20:13:41 -0400 (EDT)
Cc: cw@sgi.com (Christopher Wedgwood),
       marcelo@conectiva.com.br (Marcelo Tosatti), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org, wildos@sgi.com
In-Reply-To: <3F149276.10600@pobox.com> from "Jeff Garzik" at Gor 15, 2003 07:47:02 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ITYM TASK_UNINTERRUPTIBLE, because you definitely don't handle being 
> interrupted... :)

<2.4 IDE maintainer hat on>
Marcelo can you skip integrating this until we work through the questions
and a few others I'll write down tomorrow, so we get this merged nicely
</Hat>
