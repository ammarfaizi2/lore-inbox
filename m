Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129942AbQJaTx6>; Tue, 31 Oct 2000 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbQJaTxs>; Tue, 31 Oct 2000 14:53:48 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:8 "EHLO pincoya.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S129942AbQJaTxh>;
	Tue, 31 Oct 2000 14:53:37 -0500
Message-Id: <200010311951.e9VJpM316006@pincoya.inf.utfsm.cl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: Message from "H. Peter Anvin" <hpa@zytor.com> 
   of "31 Oct 2000 09:38:31 -0800." <8tn02n$ig3$1@cesium.transmeta.com> 
Date: Tue, 31 Oct 2000 16:51:22 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> said:

[...]

> Sounds like what you actually need is LINK_BEFORE() LINK_AFTER() and a
> topological sort.

Was suggested before, and shot down by Linus himself... 

tsort(1) et al come handy.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
