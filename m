Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263329AbSJCNE5>; Thu, 3 Oct 2002 09:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263291AbSJCNE5>; Thu, 3 Oct 2002 09:04:57 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:39173 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S263333AbSJCNDm>; Thu, 3 Oct 2002 09:03:42 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200210031308.g93D8qck007768@green.mif.pg.gda.pl>
Subject: Re: 2.5.40 make xconfig oddities
To: linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 15:08:52 +0200 (CEST)
Cc: jbradford@dial.pipex.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Got this error on one occasion when leaving make xconfig - 'ERROR -
> Attempting to write value for unconfigured variable
> (CONFIG_BLK_DEV_IDESCSI).', but I suspect it is just a warning.
> 
> More oddly, there are two instances of 'Generic PCI IDE chipset suppport'
> in IDE, ATA and ATAPI Block devices.

The first one should probably be renamed to just:

"PCI IDE chipset support"


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
