Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262493AbTCRP4n>; Tue, 18 Mar 2003 10:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262494AbTCRP4n>; Tue, 18 Mar 2003 10:56:43 -0500
Received: from angband.namesys.com ([212.16.7.85]:42141 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262493AbTCRP4l>; Tue, 18 Mar 2003 10:56:41 -0500
Date: Tue, 18 Mar 2003 19:07:33 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: kernel nfsd
Message-ID: <20030318190733.A29438@namesys.com>
References: <20030318155731.1f60a55a.skraw@ithnet.com> <15991.15327.29584.246688@charged.uio.no> <20030318164204.03eb683f.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318164204.03eb683f.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Mar 18, 2003 at 04:42:04PM +0100, Stephan von Krawczynski wrote:

> > The comment in the code just above the printk() reads
> >                 /* Now that IS odd.  I wonder what it means... */
> > Looks like you and Neil (and possibly the ReiserFS team) might want to
> > have a chat...
> I'm all for it. Who has a glue? I have in fact tons of these messages, it's a
> pretty large nfs server.

What is the typical usage pattern for files whose names are printed?
Are they created/deleted often by multiple clients/processes by any chance?

Bye,
    Oleg
