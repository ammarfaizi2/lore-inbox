Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFZFAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFZFAR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 01:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVFZFAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 01:00:17 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:54035 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S261278AbVFZFAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 01:00:06 -0400
Message-ID: <42BE3645.4070806@cisco.com>
Date: Sun, 26 Jun 2005 14:59:49 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Valdis.Kletnieks@vt.edu, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com>
In-Reply-To: <42BDC422.6020401@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>There has been no response to the technical email asking for what
>exactly it is that is duplicative, and what exactly it is that ought to
>be changed in how the code works, as opposed to what file the code is
>placed in, or who is considered its maintainer.    There has been no
>response to the questions about whether the difference between class and
>instance makes our layer non-duplicative.
>
>Perhaps no response was possible?
>  
>
Hans,

the l-k community have asked YOU may times.  any lack of response isn't 
because of the kernel cabal .. its because YOU are refusing to entertain 
any notion that what Reiser4 has implemented is unpalatable to the 
kernel community.

you can threaten all you want to take your code and move it to BSD.  or 
fork the kernel.  whatever.
but if you want to get your work into the mainline kernel, you need to 
provide answers to the question that keeps being asked of you - and 
which you patently keep ignoring time & time again.

in short,  as per Message-ID: <42BBC710.8010906@cisco.com>:
    posting to l-k on "why Reiser4 cannot use VFS infrastructure for
    [crypto,compression,blahblah] plugins" - ideally, for each plugin.

or again, in Message-ID: <42BBB1FA.7070400@cisco.com>:
    [..] but instead just understand that this is the framework that you 
have to
    work in to get it into the mainline kernel.
    if you don't want to go down that path, you're free to do so.
    its open source, you can keep your own linux-kernel fork.
    but if you want to get your code into mainline, i don't think its
    so much a case of l-k folks telling you how to make your code
    work under VFS.  the onus is on you to say WHY your code
    and plugins could never be put into VFS.

or further back in Message-ID: <42BB7083.2070107@cisco.com>
    you know that VFS is the mechanism in Linux.  you know
    (i hope..) how it works.  it isn't so hard to see how many
    of the Reiser4 "plug-ins" could be tied into VFS calls.
    OR, if they cannot TODAY, propose how VFS _COULD_ be
    made to do this.


NB. it doesn't matter what David thinks.  this is linux-kernel, not 
linux-users.


cheers,

lincoln.

>  
>
