Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTIXRco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 13:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTIXRco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 13:32:44 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:12833 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S261566AbTIXRcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 13:32:43 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200309241732.h8OHWj05015957@green.mif.pg.gda.pl>
Subject: Re: Minimizing the Kernel
To: linux-kernel@vger.kernel.org (kernel list)
Date: Wed, 24 Sep 2003 19:32:45 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well for starters dont use gcc 3 or above.. code size has increased
> > dramatically with thoose versions. sure they give you more optimization
> Hmm, has anyone tried -Os with gcc3+ ?
> Maybe that'd be good for size optimization?

AFAIK, the -Os optimization in gcc3 gives you larger binary than -Os in
gcc2.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
