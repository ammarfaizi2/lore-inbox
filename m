Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTIWWSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTIWWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:18:05 -0400
Received: from mail.inter-page.com ([12.5.23.93]:64006 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S262094AbTIWWSB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:18:01 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "=?iso-8859-1?Q?'Markus_H=E4stbacka'?=" <midian@ihme.org>,
       "'Justin Piszcz'" <jpiszcz@lucidpixels.com>
Cc: "'Kernel Mailinglist'" <linux-kernel@vger.kernel.org>
Subject: RE: Spam/LKML
Date: Tue, 23 Sep 2003 15:17:31 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA/3qAtyqDgUWIolxPnInj5QEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1064341489.12580.4.camel@midux>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It happens because someone on the list has the virus.  The virus, among
other thing, harvests the email addresses to forge the From: header.

So they (probably multiples of them) run their unpatched and virus-infected
Outlook.  Each of them both generates email to all the addresses they see
and each of those emails is "From" one of the other addresses they see.

So it harvests the current inbox, and does a splatter mailing.  When the
mail servers see the email and bounce it, it is bounced to your address
instead of the real senders'.

Shame there are people that think they are smart enough to play in this
space (LKML) and dumb enough to open an email attachment that they don't
fully understand/appreciate.

Further stupidity is using the "preview pane".  In Outlook, the preview pane
"opens" the email, even if you are doing a left-click delete.  Since some of
the viruses (and almost all of the spam) will validate the email account as
interactively in use when you open it, they get hammered extra-hard.

"Frend's don't ask friends to open Microsoft Documents" 

Rob White

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Markus Hästbacka
Sent: Tuesday, September 23, 2003 11:25 AM
To: Justin Piszcz
Cc: Kernel Mailinglist
Subject: Re: Spam/LKML

I've noticed this too. I get around 100 mails/day of the new "security
update". And then I get 50 more which tell's me that some message could
not be delivered, which is of course a lie. None of the mail's contain
"To: ...snip..." and I think this happens because my mail adress is in
LKML.

Regards,
----
Markus Hästbacka <midian@ihme.org>


