Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbSAPSlG>; Wed, 16 Jan 2002 13:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSAPSk7>; Wed, 16 Jan 2002 13:40:59 -0500
Received: from codepoet.org ([166.70.14.212]:59597 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S286999AbSAPSki>;
	Wed, 16 Jan 2002 13:40:38 -0500
Date: Wed, 16 Jan 2002 11:40:36 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Theodore Tso <tytso@mit.edu>, Juan Quintela <quintela@mandrakesoft.com>,
        Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        felix-dietlibc@fefe.de
Subject: Re: [RFC] klibc requirements, round 2
Message-ID: <20020116184036.GB32184@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Theodore Tso <tytso@mit.edu>,
	Juan Quintela <quintela@mandrakesoft.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, felix-dietlibc@fefe.de
In-Reply-To: <20020110231849.GA28945@kroah.com> <m2r8ovjpey.fsf@trasno.mitica> <20020114125433.A1357@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114125433.A1357@thunk.org>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 14, 2002 at 12:54:33PM -0500, Theodore Tso wrote:
> 
> In any case, given that e2fsprogs is already portable to NetBSD and
> Solaris (the latter so I can run purify to catch memory errors), it
> shouldn't be particularly difficult to get e2fsprogs to run on some
> other alternative libc.

It works just fine with uClibc..  Both shared and static,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
