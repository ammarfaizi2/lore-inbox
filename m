Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUHBMQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUHBMQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 08:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUHBMQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 08:16:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48568 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266488AbUHBMPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 08:15:53 -0400
Message-Id: <200408020317.i723HJbp007491@localhost.localdomain>
To: Andrea Arcangeli <andrea@suse.de>
cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Sun, 01 Aug 2004 17:51:28 +0200." <20040801155128.GG6295@dualathlon.random> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 01 Aug 2004 23:17:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> said:

[...]

> note this isn't a build number (the features in 2.6.10 don't matter at
> all, the only thing it matters is that all security bugs up to 3503 are
> included).

Pray tell, how do you know if a random "compiler warning fix" isn't a plug
for an exploitable hole, and if a "security fix" really does fix a real
security problem that can be abused?

Truth is, you can never know. So, this degenerates into sequential patch
numbering, which is completely hopeless.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
