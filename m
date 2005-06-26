Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVFZHLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVFZHLY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 03:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVFZHLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 03:11:24 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:16655 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261406AbVFZHJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 03:09:28 -0400
X-IronPort-AV: i="3.93,230,1115017200"; 
   d="scan'208"; a="194327879:sNHT28894140"
Message-ID: <42BE5492.4030903@cisco.com>
Date: Sun, 26 Jun 2005 17:09:06 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>            <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <42BE3A90.1090403@slaphack.com>
In-Reply-To: <42BE3A90.1090403@slaphack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>Ok, I'll bite.  Hans put it best a moment ago:
>  
>
[..]

you seem to have some misconceived notion that this is somehow a 
"ReiserFS versus XFS" or "ReiserFS versus ext3" case.
l-k could do without those conspiracy theories.  lets just stick to the 
facts.

>No, as a user, I just want a working plugin architecture to play with
>(I'm not *just* a user), and a working Reiser4 'cause it's fast, and I
>am eager to see new improvements coming out of Namesys, instead of two
>years spent trying to keep up with the vanilla kernel *and* adapt to
>some unspecified, possibly unneccessary, decree of a benevolent dictator.
>  
>
one of the nice things about linux is the freedom open-source gives you.
there is no reason why Hans cannot keep whatever proprietary mechanisms 
to do whatever fancy plugins he wants and you as a user can use until 
the cows come home.

but just don't have the false expectation that just because something is 
'kool' that its going to get into the kernel without rigorous peer 
review & approval


cheers,

lincoln.

>  
>
