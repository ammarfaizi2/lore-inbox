Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266366AbRGFKsN>; Fri, 6 Jul 2001 06:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbRGFKsD>; Fri, 6 Jul 2001 06:48:03 -0400
Received: from MailAndNews.com ([199.29.68.123]:19206 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S266366AbRGFKry>;
	Fri, 6 Jul 2001 06:47:54 -0400
X-WM-Posted-At: MailAndNews.com; Fri, 6 Jul 01 06:47:32 -0400
Message-ID: <006301c10608$eb980c80$0100a8c0@chello.nl>
From: "Marc Brekoo" <m_brekoo@mailandnews.com>
To: "Xavier Bestel" <xavier.bestel@free.fr>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <01e901c105a5$a0205220$0100a8c0@chello.nl> <994405675.5488.2.camel@nomade>
Subject: Re: [OT] Maintainers master list: new idea
Date: Fri, 6 Jul 2001 12:46:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel said:

> I have another suggestion for the MAINTAINER list:
>
> Put the filenames/directories the maintainer is responsible of, perhaps
> in a hierarchical tree (X maintains usb drivers, Y maintains usb
> keyboards, Z maintains usb keyboard from such vendor).
> This should be coherent and easily parsable.
>
> This way, someone which has to send several patches can make a little
> script which finds the correct maintainers to send its stuff to.
> I've already been in that situation, currently it's a pain.

Wouldn't that be the same as including metadata in the files itself? The
only thing that's different in this approach is that the metadata isn't
included into the code itself, but in a seperate database.

But, maybe this isn't such a bad idea, because it is a _damn_ pain.... :)

I'm currently working on some code to make this website I was talking about,
and I'll include this as soon as it works well enough.

Regards,
Marc Brekoo.

