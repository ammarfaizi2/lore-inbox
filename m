Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVLFKZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVLFKZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 05:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVLFKZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 05:25:51 -0500
Received: from web30612.mail.mud.yahoo.com ([68.142.201.245]:29610 "HELO
	web30612.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932548AbVLFKZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 05:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ddVyhLClIWaOmfVKuxK0Aygm0r7GJjiAvsnAI35arYq5Kni7intRkktX/vTnsSLx3vPBFLjcI9sNo7lNAis1ul953wB60xKp9/Dkung5l2ocibZv+MtBkci46Uyc1+zBXfxTsn2dSb/JbuwOQPtA3wNXxW1H7NdT9xFhlCIw8JA=  ;
Message-ID: <20051206102549.27245.qmail@web30612.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 11:25:49 +0100 (CET)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Kernel BUG at page_alloc.c:117!
To: Keith Mannthey <kmannth@gmail.com>, Rob Landley <rob@landley.net>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <a762e240512052138i3243761fl25f750f351f0b7f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Indeed, It's a RedHat station. But I want first to
know if it's a kernel bug or not.
Perhaps the informations (logs, modules, ksymoops ) I
gived you are not sufficient.
I want to understand what's happen because the problem
is not reproductible.
 
Is it due to a module that I load? (I think to the
module "wdpiano"...?)
Is it a hardware problem...? (such as RAM, or I/O
error )
How can I determine the origine of the problem?

The sar base (I can send the file if you need it)
don't help me a lot... (all seems to be ok)

Thanks for your help.

Zine

PS : I don't know if you have already received this
mail; that's why I send it again without the attached
file... excuses me for the noise..

--- Keith Mannthey <kmannth@gmail.com> a écrit :

> You might want to file a bug with the distro you are
> running. The
> kernel numbering seems to be RedHat?  Perhaps they
> have seen and fixed
> the problem already upsteam in their tree somewhere.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
