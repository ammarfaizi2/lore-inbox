Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVISLjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVISLjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 07:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVISLjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 07:39:44 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:30359 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932097AbVISLjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 07:39:42 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17198.38220.257000.445906@gargle.gargle.HOWL>
Date: Mon, 19 Sep 2005 14:39:08 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: thenewme91@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Denis Vlasenko <vda@ilport.com.ua>, chriswhite@gentoo.org,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <432E5024.20709@namesys.com>
References: <200509182004.j8IK4JNx012764@inti.inf.utfsm.cl>
	<432E5024.20709@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:

[...]

 > Well maybe he should just go away then and save his and our time. 
 > Reiser4 works just fine without Christoph.  Users are happy with it. 
 > None of them have asked for his help.  I don't consider Christoph to be
 > qualified to work on our filesystem.  I would not hire him if he applied
 > --- he is not capable of innovative work.

Hans, it seems you misunderstand what is going on.

Necessary prerequisite for reiser4 inclusion is a review by file system
people. Christoph is doing this _work_. You know what it is to review
somebody else code? It's a hard work. He is doing it for free.

If he goes away---reiser4 wouldn't somehow magically be immediately
included into kernel. It'll wait for review---for the next person to
come and to do this work. And that person will most likely point to the
very same things that hch does now only after a delay. Maybe with
slightly more polished style (hair style included) though. :-)

So, please be a little more patient.

 > 
 > Reiser4 is far from perfect, but it is ready for more users.

This is not what is being discussed, stop red-herring, please.

[...]

 > >
 > Yes, which is why people who have not written a serious filesystem
 > should not instruct those who have written the measurably fastest one.

Somebody has to review reiser4 code. If you can persuade somebody else
to do the review, do this.

[...]

 > 
 > V4, as it is today, is as much superior to V3 as OS/2 was to DOS.  Any

One way in which half-OS was superior to DOS was how spectacularly the
former project failed after a lot of hype. :-)

 > distro or user who would stay with V3 for new installs once we have
 > passed mass testing is nuts.  We need the mass testing.
 > 
 > Hans
 > 

Nikita.
