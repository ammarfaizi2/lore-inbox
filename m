Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUF1S7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUF1S7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUF1S7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:59:35 -0400
Received: from docsis224-219.menta.net ([62.57.224.219]:27569 "EHLO
	pof.eslack.org.") by vger.kernel.org with ESMTP id S265128AbUF1S7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:59:34 -0400
Subject: Re: Doubt
From: Esteve =?ISO-8859-1?Q?Espu=F1a?= Sargatal <esteve@eslack.org>
Reply-To: esteve@eslack.org
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040628184345.18629.qmail@web90103.mail.scd.yahoo.com>
References: <20040628184345.18629.qmail@web90103.mail.scd.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1088449171.7289.3.camel@esteve.pofhq.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 28 Jun 2004 20:59:31 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Example from  arch/i386/kernel/kgdb_stub.c:


#include <asm/string.h>         /* for strcpy */

static char remcomOutBuffer[BUFMAX];

strcpy(remcomOutBuffer, "OK");

Hope it's ok.

On Mon, 2004-06-28 at 20:43, so usp wrote:
> Hi...
> 
> i would like to know how to copy a string such as
> "Test" to a char vector (char buffer[256]) in kernel
> mode.
> 
> Thanks,
> Luis Henrique.
> 
> ______________________________________________________________________
> 
> Yahoo! Mail - agora com 100MB de espaço, anti-spam e antivírus grátis!
> http://br.info.mail.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

