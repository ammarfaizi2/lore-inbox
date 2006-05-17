Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWEQPt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWEQPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWEQPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:49:28 -0400
Received: from web26606.mail.ukl.yahoo.com ([217.146.176.56]:58254 "HELO
	web26606.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750723AbWEQPt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:49:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2OZaVtESauXmGqNcvLekfnmrJwYz6VKXEAG6JylnesoUpRXcTPdSqlhHynhoPHjcyHx3s6sAjq+UOGB9frmUePVLerFM163wZS91N6gblwd/0v3L7wyTH+VRJeaI0qDDGyLqyX2Orchex4TUVYBPS/phsLU6FswEOqoNl39W4/c=  ;
Message-ID: <20060517154926.35649.qmail@web26606.mail.ukl.yahoo.com>
Date: Wed, 17 May 2006 17:49:26 +0200 (CEST)
From: linux cbon <linuxcbon@yahoo.fr>
Subject: Re: replacing X Window System !
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1147879010.10470.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Alan Cox <alan@lxorguk.ukuu.org.uk> a écrit : 
> On Mer, 2006-05-17 at 16:53 +0200, linux cbon wrote:
> > We dont need 2 kernels like today.
> > All "dangerous code" should be in kernel.
> 
> The kernel is even more privileged than the X server
> so putting
> dangerous code there is counterproductive. Security
> comes about through
> intelligent design decisions, compartmentalisation,
> isolation of
> security critical code segments and the like. If you
> merely put shit in
> a different bucket you still have a bad smell.


With "dangerous code" I meant : code which *could be
potentially dangerous* like accessing directly the
hardware etc.
That code should be only in the kernel.











	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
