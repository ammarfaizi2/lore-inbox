Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTJPO3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbTJPO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 10:29:54 -0400
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:41194 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S262989AbTJPO3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 10:29:53 -0400
To: rintek@wuuk.sulawesi
Cc: linux-kernel@vger.kernel.org
Subject: Re: Contradiction ?
X-URL: <http://www.linux-mandrake.com/
References: <bmm0rc$7c8$1@news.cistron.nl>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Thu, 16 Oct 2003 14:29:47 +0000
In-Reply-To: <bmm0rc$7c8$1@news.cistron.nl> (rintek@wuuk.sulawesi's message
 of "Thu, 16 Oct 2003 13:55:18 +0200")
Message-ID: <m2y8vl45no.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rintek@wuuk.sulawesi writes:

> pdc202xx_old.c :
> 
> linux/drivers/ide/pci/pdc202xx_old.c    Version 0.36    Sept 11, 2002
> Copyright (C) 1998-2002         Andre Hedrick <andre@linux-ide.org>
> 
> pdc202xx_new.c :
> 
> linux/drivers/ide/pdc202xx.c    Version 0.35    Mar. 30, 2002
> Copyright (C) 1998-2002         Andre Hedrick <andre@linux-ide.org>
> 
> Hi,
> 
> I am confused.
> 
> Is pdc202xx_old.c version 0.36 Sept 11, 2002 the newest driver ?
> 
> or
> 
> Is pdc202xx_new.c version 0.35 Mar. 30, 2002 the newest driver ?

pdc202xx_old handle older pdc controllers
pdc202xx_new handle newer pdc controllers
just read the help into the config system

