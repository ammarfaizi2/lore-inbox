Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933348AbWKNJde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933348AbWKNJde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933352AbWKNJde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:33:34 -0500
Received: from ic0245.upco.es ([130.206.70.245]:24222 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S933348AbWKNJdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:33:33 -0500
Subject: Re: pcmcia: patch to fix pccard_store_cis
From: Romano Giannetti <romanol@upcomillas.es>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Cc: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200611140040.02079.daniel.ritz-ml@swissonline.ch>
References: <200611140040.02079.daniel.ritz-ml@swissonline.ch>
Content-Type: text/plain;
	charset=utf-8
Date: Tue, 14 Nov 2006 10:33:30 +0100
Message-Id: <1163496810.2798.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 00:40 +0100, Daniel Ritz wrote:
> please also try this patch on top:
> 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=e6248ff596dd15bce0be4d780c60f173389b11c3
>
> (after you have "[PATCH] pcmcia: start over after CIS override"
> 	http://zeus2.kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-fixes-2.6.git;a=commitdiff;h=f755c48254ce743a3d4c1fd6b136366c018ee5b2
>  applied)

Applied, with just a bit of offset on 2.6.17.13. Compiling now. I'll be
back to you as soon as possible.

> if that doesn't work, i'll have a look at it on the weekend.

Thanks a lot.

--
Romano Giannetti --- romano.giannetti@gmail.com
Sorry for the following disclaimer, it's attached by our otugoing server
and I cannot shut it up.



--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation.

