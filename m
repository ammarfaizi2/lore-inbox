Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVKTXjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVKTXjl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVKTXjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:39:41 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:33034 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932129AbVKTXjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:39:40 -0500
To: Tarkan Erimer <tarkane@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Sun's ZFS and Linux
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com>
	<20051119172337.GA24765@thunk.org>
	<9611fa230511201312r5f43e8ady7023b4bde170596e@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: more boundary conditions than the Middle East.
Date: Sun, 20 Nov 2005 23:39:08 +0000
In-Reply-To: <9611fa230511201312r5f43e8ady7023b4bde170596e@mail.gmail.com> (Tarkan
 Erimer's message of "20 Nov 2005 21:12:42 -0000")
Message-ID: <87r79a7uub.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov 2005, Tarkan Erimer yowled:
> On 11/19/05, Theodore Ts'o <tytso@mit.edu> wrote:
>> That wouldn't be a "port", it would have to be a complete
>> reimplementation from scratch.  And, of course, of further concern
>> would be whether or not there are any patents that Sun may have filed
>> covering ZFS.  If the patents have only been licensed for CDDL
>> licensed code, then that won't help a GPL'ed covered reimplementation.
> 
> Thanks for the explanation. BTW, I wonder something: Is there any
> possibility to give GPL an exception to include and/or link to CDDL
> code?

You'd have to get agreement from *all* the kernel's past
contributors. As some of them are dead this is not likely to happen.

(Well, OK, you could isolate their code and rewrite it but this
would be a big and annoying job, so you'd need a very compelling
reason. One extra filesystem isn't likely to be good enough.)

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

