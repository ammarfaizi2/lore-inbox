Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSJaKJ1>; Thu, 31 Oct 2002 05:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264802AbSJaKJ0>; Thu, 31 Oct 2002 05:09:26 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:50381 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S264799AbSJaKJ0>; Thu, 31 Oct 2002 05:09:26 -0500
Subject: Re: What's left over.
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1036059364.2419.1.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 31 Oct 2002 05:16:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-30 at 21:31, Linus Torvalds wrote:

> > ext2/ext3 ACLs and Extended Attributes
> 
> I don't know why people still want ACL's. There were noises about them for 
> samba, but I'v enot heard anything since. Are vendors using this?
> 

I am sure I don't count (not being a vendor), but Intermezzo offers
support for this (they are waiting on feature freeze to redo it to 2.5
according to an email I have).  I want this stuff.  Yes, u+g+w is nice,
but good ACLs are even better.  Please, if this is technically correct
in implementation, do put it in.

Thank you,
Trever

