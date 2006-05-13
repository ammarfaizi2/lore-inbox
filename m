Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWEMQ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWEMQ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEMQ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 12:59:16 -0400
Received: from xenotime.net ([66.160.160.81]:4265 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932481AbWEMQ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 12:59:15 -0400
Date: Sat, 13 May 2006 10:01:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: gleb@minantech.com, mingo@elte.hu, akpm@osdl.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 00/02] update to Document futex PI design
Message-Id: <20060513100142.d437a6b2.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com>
	<20060510101729.GB31504@elte.hu>
	<Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com>
	<20060510124600.GN5319@minantech.com>
	<Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006 09:27:48 -0400 (EDT) Steven Rostedt wrote:

> 
> Andrew,
> 
> The following two patches update the rt-mutex-design.txt document.
> 
> The first one simply removes all the tabs that I had in that document.
> Since it's a document and not code, tabs are not really appropiate.

I think that lots of people would not agree with that sentiment.
Documentation/*.txt has approximately 8800 lines with tabs in them
(just top-level Doc/*.txt, not sub-directories).

---
~Randy
