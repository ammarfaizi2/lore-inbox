Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290310AbSAYLkC>; Fri, 25 Jan 2002 06:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290647AbSAYLjm>; Fri, 25 Jan 2002 06:39:42 -0500
Received: from AMontpellier-201-1-1-52.abo.wanadoo.fr ([193.252.31.52]:59150
	"EHLO awak") by vger.kernel.org with ESMTP id <S290310AbSAYLjl> convert rfc822-to-8bit;
	Fri, 25 Jan 2002 06:39:41 -0500
Subject: Re: RFC: booleans and the kernel
From: Xavier Bestel <xavier.bestel@free.fr>
To: Thomas Hood <jdthood@mail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1011958120.1219.2.camel@thanatos>
In-Reply-To: <1011958120.1219.2.camel@thanatos>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 12:39:11 +0100
Message-Id: <1011958751.2635.25.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 25-01-2002 à 12:28, Thomas Hood a écrit :

> In that case, perhaps it would be more perspicuous to define
> a "bit" type rather than a "bool" type, and to use 0 and 1 as
> its values rather than 'true' and 'false'.  (A "bit" type 
> would have all the advantages mentioned earlier by Peter Anvin
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101191106124169&w=2 .)

in the hypothetical 'bit type' case:

bit n;
n = 2;
printf("n = %d\n", n);

guess what ? n = 0

	Xav


