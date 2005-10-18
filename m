Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVJRCob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVJRCob (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 22:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVJRCob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 22:44:31 -0400
Received: from xenotime.net ([66.160.160.81]:48343 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932391AbVJRCoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 22:44:30 -0400
Date: Mon, 17 Oct 2005 19:44:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO scheduler
Message-Id: <20051017194428.38f0a7b1.rdunlap@xenotime.net>
In-Reply-To: <6694B22B6436BC43B429958787E454988F5B11@mssmsx402nb>
References: <6694B22B6436BC43B429958787E454988F5B11@mssmsx402nb>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2005 20:12:18 +0400 Ananiev, Leonid I wrote:

> Randy,
> You are right. The lines is broken if I send patch outside Intel (I've
> tried to send @mail.ru)
> Inside Intel the lines are not broken as I see in response mails.
> I've used 'Plain text" before but flag "Use MS Word 2003 to edit e-mail
> massages" was not turned off.
> Now this flag is turned off. Once more I had opened using WordPad the
> diff-text created on Linux and have pasted it in this mail.
> Is it OK in your mail client?

No:

patch: **** malformed patch at line 52: *rq)

Fix one, try again:

patch: **** malformed patch at line 79: *rq)

again:

patch: **** malformed patch at line 175: *rq)

again:
patch: **** malformed patch at line 247: *cfqq)

In general:  copy-paste often has problems in Linux.  I don't
know about in Windows.

In general:  you might be better off trying to use attachments.


> But I've send long patch line to @mail.ru and I've seen the lines still
> broken.
> It is not permitted to use mail client other than MS Outlook in our
> office.

That needs to be fixed.  There are some decent email clients for
Windows, like Netscape/Mozilla, Thunderbird, sylpheed (beta),
even Eudora.

> Randy writes
> >You should also make sure that it applies cleanly
> > to the current kernel version
> 
> I've applied it to linux-2.6.14-rc4
> ----------------------------------------------------

---
~Randy
