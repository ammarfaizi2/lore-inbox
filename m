Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281011AbRKOThj>; Thu, 15 Nov 2001 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281012AbRKOTh3>; Thu, 15 Nov 2001 14:37:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:4100 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281011AbRKOThU>; Thu, 15 Nov 2001 14:37:20 -0500
Message-ID: <002501c16e0c$d3800550$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: <linux-kernel@vger.kernel.org>
Subject: Microsoft IE6 is crashing with Linux 2.4.X
Date: Thu, 15 Nov 2001 12:35:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have upgraded several W2K boxes to the latest IE6 packages I downloaded
from Microsoft's website.  I am seeing a behavior which appears to be a bug.
It appears to be malicious "malfunctioning" with some sort of deliberate
breakage designed to create incompatibility between Linux and W2K mail
systems.  Attempts to relay mail via sendmail/Linux is resulting in the
following message.  This message shows up 1 out of 3 times or so relaying
emails from Outlook IE6 through a Linux server:

The connection to the server has failed. Account: 'mail.timpanogas.org',
Server: 'mail.timpanogas.org', Protocol: SMTP, Port: 25, Secure(SSL): No,
Socket Error: 10061, Error Number: 0x800CCC0E

The IE5 clients and earlier IE6 clients do not exhibit this behavior.  Does
anyone know if Linux has broken something or can verify this behavior
independent of what we are seeing?
It looks like MS up to their old tricks of creating annoyances for customers
which are designed to look like bugs in our software.  When I was at Novell,
I saw these types of things regularly in their software (i.e. DRDOS,
NetWare, etc.) designed to deliberately create incompatibility and breakage
at customer sites.  I am not certain this is what is happening here, but if
someone else can verify, then perhaps this is the case, and we should alert
Linux users.

Thanks

Jeff

