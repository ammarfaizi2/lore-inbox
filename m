Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281159AbRKPHE2>; Fri, 16 Nov 2001 02:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281160AbRKPHET>; Fri, 16 Nov 2001 02:04:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22656 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281159AbRKPHEE>; Fri, 16 Nov 2001 02:04:04 -0500
Message-ID: <000001c16e6c$c29061d0$f5976dcf@nwfs>
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <002501c16e0c$d3800550$f5976dcf@nwfs> <1005854832.2730.1.camel@heat>
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X
Date: Thu, 15 Nov 2001 14:45:39 -0700
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

According to some folks who responded to this, IE6 is just plain broken.  I
apologize for the lateness of responding, but my Linux server crashed with
sendmail spawing thread after thread and my /var/spool/mqueue directory
filled to bursting with corrupted mail headers.  IE6 got into some kind of
braindead loop where it started flooding sendmail with tons of bogus (and
garbage) mail headers.

It's clearly a piece of sh_t browser.  This latest release qualifies as a
computer virus.  It's much more destructive that lion every dreamed of
being.

Jeff


----- Original Message -----
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, November 15, 2001 1:07 PM
Subject: Re: Microsoft IE6 is crashing with Linux 2.4.X


> On Thu, 2001-11-15 at 11:35, Jeff V. Merkey wrote:
> >
> > I have upgraded several W2K boxes to the latest IE6 packages I
downloaded
> > from Microsoft's website.  I am seeing a behavior which appears to be a
bug.
>
> Be a lot more interesting email if you included a dump of the actual
> network traffic.  -jwb

