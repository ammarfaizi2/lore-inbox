Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbSI3CDZ>; Sun, 29 Sep 2002 22:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261899AbSI3CDZ>; Sun, 29 Sep 2002 22:03:25 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:31748 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S261898AbSI3CDZ>; Sun, 29 Sep 2002 22:03:25 -0400
Message-Id: <200209300208.g8U28lSm002868@pincoya.inf.utfsm.cl>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39-bk current compile failure 
In-Reply-To: Message from Horst von Brand <vonbrand@inf.utfsm.cl> 
   of "Sun, 29 Sep 2002 20:02:25 -0400." <200209300002.g8U02Pis024933@pincoya.inf.utfsm.cl> 
Date: Sun, 29 Sep 2002 22:08:46 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: 2.5.39-bk current compile failure
> kernel/ksyms.c is missing declarations for tvec_bases, bh_task_vec, init_bh,
> remove_bh, __run_task_queue
> 
> In the middle of a big update?

Right. Next bk pull got rid of this.

Sorry for the noise.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
