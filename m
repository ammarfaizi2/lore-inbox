Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129301AbQJ0Tr6>; Fri, 27 Oct 2000 15:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQJ0Trj>; Fri, 27 Oct 2000 15:47:39 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:43268 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S129301AbQJ0Trf>; Fri, 27 Oct 2000 15:47:35 -0400
Message-Id: <200010271946.e9RJk6K01211@pincoya.inf.utfsm.cl>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu detection fixes for test10-pre4 
In-Reply-To: Message from "H. Peter Anvin" <hpa@transmeta.com> 
   of "Fri, 27 Oct 2000 11:43:23 PDT." <39F9CCCB.538FAEBA@transmeta.com> 
Date: Fri, 27 Oct 2000 16:46:06 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@transmeta.com>said:
> Alan Cox wrote:

[...]

> > > We should never have used anything but "i386" as the utsname... sigh.

> > Its questionable if we should include the 'i'

> True enough, personally I prefer "x86".

ia32 is the official name. OTOH, i[3-6]86 _are_ different beasts...
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
