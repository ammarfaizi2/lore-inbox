Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbTLKRoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTLKRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:44:09 -0500
Received: from [212.28.208.94] ([212.28.208.94]:37636 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265174AbTLKRoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:44:07 -0500
From: Robin Rosenberg <roro.l@dewire.com>
To: Larry McVoy <lm@bitmover.com>, Kendall Bennett <KendallB@scitechsoft.com>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 18:44:03 +0100
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com> <3FD7081D.31093.61FCFA36@localhost> <20031210221800.GM6896@work.bitmover.com>
In-Reply-To: <20031210221800.GM6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111844.03839.roro.l@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

onsdagen den 10 december 2003 23.18 skrev Larry McVoy:
> On Wed, Dec 10, 2003 at 11:48:45AM -0800, Kendall Bennett wrote:
[...]
> Not only that, I think the judge would have something to say about the
> fact that the modules interface is delibrately changed all the time
> with stated intent of breaking binary drivers.  In fact, Linus pointed
> out his thoughts on what the judge would say:
>
>     In fact, I will bet you that if the judge thinks that you tried to
>     use technicalities ("your honour, I didn't actually run the 'ln'
>     program, instead of wrote a shell script for the _user_ to run the
>     'ln' program for me"), that judge will just see that as admission
>     of the fact that you _knew_ you were doing something bad.
>
> Why is it that the judge wouldn't see the delibrate changing of the
> interfaces, the EXPORT_GPL stuff, all of that as a way to delibrately
> force something that wouldn't otherwise be a derived work into a
> derived work category?

If EXPORT_GPL is changed as a means of protecting the copyright, i..e. provide
source code access. then doesn't this "mechanism" fall under the infamous DMCA, 
i.e. you're not allowed to even think about circumventing it...

-- robin

