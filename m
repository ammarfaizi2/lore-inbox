Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVJFGoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVJFGoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 02:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbVJFGoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 02:44:17 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24010 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751240AbVJFGoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 02:44:17 -0400
Date: Thu, 6 Oct 2005 02:43:09 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Marc Perkel <marc@perkel.com>
cc: Florin Malita <fmalita@gmail.com>, lsorense@csclub.uwaterloo.ca,
       nix@esperi.org.uk, 7eggert@gmx.de, lkcl@lkcl.net,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <43442D19.4050005@perkel.com>
Message-ID: <Pine.LNX.4.58.0510060235180.28535@localhost.localdomain>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
 <4343E611.1000901@perkel.com> <20051005144441.GC8011@csclub.uwaterloo.ca>
 <4343E7AC.6000607@perkel.com> <20051005153727.994c4709.fmalita@gmail.com>
 <43442D19.4050005@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Oct 2005, Marc Perkel wrote:
> What you don't get is that if you don't have rights to write to a file
> then you shouldn't have the right to delete the file.  Once you get past
> the "inside the box" Unix thinking you'll see the logic in this. So what
> if the process of deleting a file involves writing to it. That's not
> relevant.

Marc, Get off of it!

In 1987 I first started using Unix. Before that I worked mostly on DOS.
At first the delete w/o ownership shocked me, but then I changed my POV
thinking and found that unlinking from a directory only took write access
to the directory and it made sense to me.  This was all before I began to
"think inside the Unix box".  In fact, it was when I was "thinking inside
the DOS box".

God I was 19 at the time and I easily got a clue. You are stuck on your
own POV and you cant seem to see anything any other way.  So stop trying
to convince us.  We can make up our own minds and already have.

-- Steve

