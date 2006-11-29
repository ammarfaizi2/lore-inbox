Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758920AbWK2W4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920AbWK2W4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758922AbWK2W4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:56:33 -0500
Received: from ic0245.upco.es ([130.206.70.245]:55426 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1758920AbWK2W4c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:56:32 -0500
Subject: Re: Linux 2.6.19
From: Romano Giannetti <romano@dea.icai.upcomillas.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
Content-Type: text/plain;
	charset=utf-8
Date: Wed, 29 Nov 2006 23:55:39 +0100
Message-Id: <1164840939.7180.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 14:21 -0800, Linus Torvalds wrote:

> You could send me and the kernel mailing list a note about it anyway, of
> course. (And perhaps pictures, if your dachshund is involved. Not that
> we'd be interested, of course. No. Just so that we'd know to avoid it next
> time).

:-)

I had a such a dachshund when child, but he's long passed away... in his
memory, I have to say that .19 missed this:

http://lkml.org/lkml/2006/11/19/54

which fixed a regression for my PCMCIA modem (hey, it may qualify as a
pet...) from the 2.6.13 age... details here: 

http://lists.infradead.org/pipermail/linux-pcmcia/2006-August/003893.html

I understand it's not the classical one-liner accepted in a -rc6 stage,
but I feel it's not bad to point it out again so that it will be
considered for the next kernel. And to signal it as a candidate for
2.6.19.y line.

Thanks,
	Romano






--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation.

