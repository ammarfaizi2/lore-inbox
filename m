Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131067AbQKJTIG>; Fri, 10 Nov 2000 14:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130575AbQKJTH7>; Fri, 10 Nov 2000 14:07:59 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:30222 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131457AbQKJTHs>; Fri, 10 Nov 2000 14:07:48 -0500
Message-Id: <200011101905.eAAJ5qi25826@pincoya.inf.utfsm.cl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue] 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@timpanogas.org> 
   of "Fri, 10 Nov 2000 11:52:00 PDT." <3A0C43D0.14039937@timpanogas.org> 
Date: Fri, 10 Nov 2000 16:05:51 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@timpanogas.org> SAID:
> "William F. Maton" wrote:

[...]

> > What about sendmail 8.11.1?  Is the problem there too?

> Yes.  Plus 8.11.1 has problems talking to older sendmails sine it uses
> encryption.

I've been using sendmail-8.11.1 (no encryption) to talk to MTAs all over
the place, many of them so old it is scary. No problems seen at this end.
This is to be expected, BTW: They can't just go in and release an MTA which
doesn't talk to the rest ot the world, now can they.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
