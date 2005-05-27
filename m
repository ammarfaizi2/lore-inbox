Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVE0Tin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVE0Tin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVE0Tim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:38:42 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:6321 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261969AbVE0Ti3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:38:29 -0400
Subject: Re: disowning a process
From: Steven Rostedt <rostedt@goodmis.org>
To: "J. Scott Kasten" <jscottkasten@yahoo.com>
Cc: Davy Durham <pubaddr2@davyandbeth.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.60.0505271447220.16016@thor.tetracon-eng.net>
References: <42975945.7040208@davyandbeth.com>
	 <Pine.SGI.4.60.0505271447220.16016@thor.tetracon-eng.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 27 May 2005 15:38:20 -0400
Message-Id: <1117222700.6477.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-27 at 14:54 -0400, J. Scott Kasten wrote:

> 
> Sounds like a job for the Richard Stevens "Advanced Programming in the 
> UNIX Environment" book.  Check out chapter 13, "daemon processes".  It 
> explains the subtleties of process groups, signals, inheritance, etc.. 
> better than most.

Definitely a good read. God rest his soul.  But it doesn't let you know
that there's already a daemon function out there.  But what daemon does
is pretty much a complete version of Stevens' example Program 13.1
"daemon_init".

Davy, I recommend that if you don't already have that book, get it.

-- Steve


