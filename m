Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUJWU2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUJWU2w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUJWU2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:28:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:62096 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261166AbUJWU2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:28:47 -0400
Message-ID: <417ABF02.4030705@namesys.com>
Date: Sat, 23 Oct 2004 13:28:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcel@hilzinger.hu
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <reiserfs-dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re:  2.6.9-mm1
References: <20041022032039.730eb226.akpm@osdl.org>    <4179425A.3080903@namesys.com> <1078.217.232.234.250.1098558101.squirrel@florka.hu>
In-Reply-To: <1078.217.232.234.250.1098558101.squirrel@florka.hu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hilzinger Marcel wrote:

>
>Too late, perhaps... SuSE Linux 9.2 will contain reiser4 (at least the
>beta testversions did). It cannot be set up via YaST during installation,
>  
>
which makes its user base pretty small. 9.3 is where we will probably 
get a lot of users. Probably more bugs will get found by the SuSE QA 
team in the next few weeks though, and that should help us.

The one I am wanting to precede regarding shipping is Lindows where we 
will be the default. Reiser4 is pretty stable now, but if we got into 
the kernel now we'd have a few weeks of bug finding before they ship, 
and I just bet there will be a few bugs found as a result (not frequent 
ones, but....) that several of their users would be happy to not hit. 
The official kernel has the advantage of a far faster test and fix time 
cycle than a distro, and has more sophisticated users. The reason for 
features going into distros first is not technical, and sad.

Hans
