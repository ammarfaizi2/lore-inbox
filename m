Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293024AbSBVWS6>; Fri, 22 Feb 2002 17:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293025AbSBVWSj>; Fri, 22 Feb 2002 17:18:39 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:48935 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S293024AbSBVWSZ> convert rfc822-to-8bit; Fri, 22 Feb 2002 17:18:25 -0500
Date: Fri, 22 Feb 2002 00:17:26 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Erik Andersen <andersen@codepoet.org>
cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020222212252.GA30290@codepoet.org>
Message-ID: <20020222001333.U2109-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Feb 2002, Erik Andersen wrote:

> On Thu Feb 21, 2002 at 10:24:22PM +0100, Gérard Roudier wrote:
> >
> > Thanks for the reply. But my concern is user convenience in _average_
> > here. Basically, I want the 99% of users that cannot afford neither need
> > nor want PCI hotplug to have their system just dead in order to make happy
> > the 1%.
>
> I think _lots_ of people have laptops -- far more than just 1%.
> Those laptops have cardbus slots, which need PCI hotplug to work
> properly.  And I _know_ that Linus has a laptop with a cardbus
> slot...

My reply was in the only context of sym53c8xx PCI-SCSI chips.
Even in the full SCSI context + laptops, the 'lots of people' you are
talking about should be near absolute zero in my opinion. :)

  Gérard.

