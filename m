Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbRFFJUP>; Wed, 6 Jun 2001 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRFFJUF>; Wed, 6 Jun 2001 05:20:05 -0400
Received: from AMontpellier-201-1-3-224.abo.wanadoo.fr ([193.252.1.224]:36857
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S261385AbRFFJT4>; Wed, 6 Jun 2001 05:19:56 -0400
Subject: Re: Break 2.4 VM in five easy steps
From: Xavier Bestel <xavier.bestel@free.fr>
To: Sean Hunter <sean@dev.sportingbet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
	<3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com>
	<991815578.30689.1.camel@nomade> 
	<20010606095431.C15199@dev.sportingbet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 11:16:27 +0200
Message-Id: <991818989.30690.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Jun 2001 09:54:31 +0100, Sean Hunter wrote:
> > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
> > anything less won't do any good: 2.4 overallocates swap even if it
> > doesn't use it all. So in your case you just have enough swap to map
> > your RAM, and nothing to really swap your apps.
> > 
> 
> For large memory boxes, this is ridiculous.  Should I have 8GB of swap?

Life is tough. If guess if you have 4GB RAM, you'd be better having no
swap at all. Or, yes, at least 8GB.
Or just wait for this bug to be fixed. But be patient.

Xav


