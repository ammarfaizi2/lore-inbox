Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135975AbRD0LKo>; Fri, 27 Apr 2001 07:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbRD0LKe>; Fri, 27 Apr 2001 07:10:34 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:753
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S135975AbRD0LK1>; Fri, 27 Apr 2001 07:10:27 -0400
Subject: Re: 2.4 and 2GB swap partition limit
From: Xavier Bestel <xavier.bestel@free.fr>
To: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <87elw8v2ay.fsf@mose.informatik.uni-tuebingen.de>
In-Reply-To: <200103031114.MAA13672@cave.bitwizard.nl> 
	<87elw8v2ay.fsf@mose.informatik.uni-tuebingen.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 27 Apr 2001 12:51:34 +0200
Message-Id: <988368729.1406.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08 Mar 2001 14:05:25 +0100, Goswin Brederlow a écrit :

> I believe the 2xRAM rule comes from the OS's where ram was only buffer
> for the swap. So with 1xRAM you had a running system with 1xRAM
> memory, so nothing is gained by that much swap.

I think kernels 2.4.x came back to this behavior.
 
> On Linux any swap adds to the memory pool, so 1xRAM would be
> equivalent to 2xRAM with the old old OS's.

no more true AFAIK

Xav

