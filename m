Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbUKRSQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUKRSQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbUKRSOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:14:25 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:38612 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262841AbUKRSJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:09:28 -0500
Message-Id: <200411181808.iAII8ECH009759@laptop11.inf.utfsm.cl>
To: Avi Kivity <avi@argo.co.il>
cc: Keith Owens <kaos@ocs.com.au>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI? 
In-Reply-To: Message from Avi Kivity <avi@argo.co.il> 
   of "Thu, 18 Nov 2004 17:47:14 +0200." <419CC402.7080109@argo.co.il> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 18 Nov 2004 15:08:13 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> said:

[...]

> ksymoops can disasemble the entire code line, but starting at different 
> offsets (up to the maximum instruction length) from the start. the first 
> disassembly to include the program counter in the output would be deemed 
> correct.

There might be several... I see no reason to consider the first one
correct.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
