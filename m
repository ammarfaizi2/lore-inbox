Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262713AbUKLXrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUKLXrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKLXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:46:40 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49025 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262722AbUKLX1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:27:46 -0500
Message-Id: <200411122326.iACNQSEn006943@gue01.inform.pucp.edu.pe>
To: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WTF is VLI? 
In-Reply-To: Message from Dave Jones <davej@redhat.com> 
   of "Thu, 11 Nov 2004 16:10:50 CDT." <20041111211050.GC32275@redhat.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 12 Nov 2004 20:26:28 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> said:
> On Thu, Nov 11, 2004 at 09:05:11PM +0000, Hugh Dickins wrote:
>  > What is this "VLI" that 2.6.9 started putting after the taint string
>  > in i386 oopses?  Vick Library Index?  Vineyard Leadership Institute?
> 
> "Variable length instructions".  I think newer ksymoops looks
> for this tag and does something magical when doing disassembly.

Huh? Either an architecture has them (i386) or doesn't (RISCs). 
Or am I seriously misunderstanding here?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
