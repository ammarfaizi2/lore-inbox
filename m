Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTCTQEL>; Thu, 20 Mar 2003 11:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbTCTQEL>; Thu, 20 Mar 2003 11:04:11 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:45065 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261520AbTCTQEK>; Thu, 20 Mar 2003 11:04:10 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200303201615.h2KGF3r2002546@green.mif.pg.gda.pl>
Subject: Re: Non-__init functions calling __init functions
To: linux-kernel@vger.kernel.org (kernel list)
Date: Thu, 20 Mar 2003 17:15:03 +0100 (CET)
Cc: stuartm@connecttech.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is always a bug isn't it?

... unless they are guaranteed to be called in the init context only.

Andrzej

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
