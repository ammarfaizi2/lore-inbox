Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTKKUP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTKKUP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:15:28 -0500
Received: from vena.lwn.net ([206.168.112.25]:58843 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263435AbTKKUP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:15:27 -0500
Message-ID: <20031111201525.1997.qmail@lwn.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Erik Jacobson <erikj@subway.americas.sgi.com>, torvalds@osdl.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Tue, 11 Nov 2003 18:22:45 GMT."
             <20031111182245.GB24159@parcelfarce.linux.theplanet.co.uk> 
Date: Tue, 11 Nov 2003 13:15:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Al - do we have some good documentation of how to use the seq-file 
> > interface? 
> 
> There was a text on LWN and it's OK for starting point.  

That would be http://lwn.net/Articles/22355/.

If you'd like a version packaged up for Documentation/, say the word and I
can do that.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
