Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbUBAV5F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUBAV5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:57:05 -0500
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:39605 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S265512AbUBAV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:57:01 -0500
Date: Sun, 1 Feb 2004 22:56:57 +0100
From: Guillermo Menguez Alvarez <gmenguez@usuarios.retecal.es>
To: Markus =?ISO-8859-15?Q?H=E4stbacka?= <midian@ihme.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uptime counter
Message-Id: <20040201225657.0d1fa882@casa.milicia.net>
In-Reply-To: <Pine.LNX.4.44.0402012314310.6574-100000@midi>
References: <200402012202.07204.kernel@borntraeger.net>
	<Pine.LNX.4.44.0402012314310.6574-100000@midi>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I just would be intrested in a patch for 2.0 and 2.4 to get these
> jiffies to 64 bit.

Maybe it's what you are looking for:

http://www.plumlocosoft.com/kernel/

It's the -ck patchset (now maintained by Eric Hustvedt for the 2.4.x
series), they have a patch to add 64 bit jiffies ot it seems so.

Regards,
Guillermo.

-- 
Usuario Linux #212057 - Maquinas Linux #98894, #130864 y #168988
Proyecto LONIX: http://lonix.sourceforge.net
Lagrimas en la Lluvia: http://www.lagrimasenlalluvia.com

