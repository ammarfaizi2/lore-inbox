Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWGXJJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWGXJJf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 05:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWGXJJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 05:09:35 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:44993 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1751066AbWGXJJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 05:09:34 -0400
Message-ID: <44C48043.7010708@namesys.com>
Date: Mon, 24 Jul 2006 02:09:39 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <44C12F0A.1010008@namesys.com> <20060722130219.GB7321@thunk.org> <44C26F65.4000103@namesys.com> <44C28A8F.1050408@garzik.org> <20060724084133.GC24299@merlin.emma.line.org>
In-Reply-To: <20060724084133.GC24299@merlin.emma.line.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:

>The most worrying point was that reiser3 maintenance was given up at the
>point where it was just about to transition from usable to mature.
>
>  
>
Name a bug (not a feature) that has not been fixed by us, and which is
not also so deep that it reasonably required waiting for a major release
to fix it (for example, bug fixes that require disk format changes
belong in v4 not v3 even if a case can be made that they are bug fixes).

I mean, god, sometimes I think users are like little children waiting
for the pie that is in the oven and who want to take it out now before
it finishes cooking so they can eat it, and they are very angry about
it, and I should just understand that and not try to reason with it (but
also not give them the pie before it finishes cooking either).   Someone
please tell me I don't understand the users and it all makes more sense
than that, please....

No code before its time.  No features in stable branches.  Wait for it. 
Stop complaining about how you are abandoned, we are working hard.  It's
going to be the best pie ever.  Wait for it.

Hans
