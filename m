Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbQKJTem>; Fri, 10 Nov 2000 14:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131486AbQKJTeb>; Fri, 10 Nov 2000 14:34:31 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:37134 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S130143AbQKJTeW>; Fri, 10 Nov 2000 14:34:22 -0500
Message-Id: <200011101930.eAAJUWi25886@pincoya.inf.utfsm.cl>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: wmaton@ryouko.dgim.crc.ca, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue] 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@timpanogas.org> 
   of "Fri, 10 Nov 2000 12:04:59 PDT." <3A0C46DB.3C347221@timpanogas.org> 
Date: Fri, 10 Nov 2000 16:30:32 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@timpanogas.org> said:
> Horst von Brand wrote:

[...]

> > I've been using sendmail-8.11.1 (no encryption) to talk to MTAs all over

> Turn on encryption, and try sending attachements > 1MB and tell me if
> you see any problems, like emails sitting in /var/spool/mqueue for a day
> or two until they go out.  I can guarantee you will.

No encryption use; and the maximal message size is 1Mb (for sanity's sake,
after somebody sent a PowerPoint presentation (some 3Mb), then thought that
perhaps the target didn't have PowerPoint, and sent it again with the
PowerPoint package, then noticed this might not work either, and sent it
_again_ with the full MS Office attached...  the joys of sysadminning ;-)
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
