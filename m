Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWIUXi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWIUXi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWIUXiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:38:25 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:63 "EHLO
	BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932114AbWIUXiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:38:25 -0400
Message-ID: <BAYC1-PASMTP07CBA42AB1F6D00285C35CAE200@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Thu, 21 Sep 2006 19:38:23 -0400
From: Sean <seanlkml@sympatico.ca>
To: David Lang <dlang@digitalinsight.com>
Cc: Dave Jones <davej@redhat.com>, Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-Id: <20060921193823.ec49d446.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0609211530180.17238@qynat.qvtvafvgr.pbz>
References: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE>
	<20060921175717.272c58ee.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
	<20060921222443.GO26683@redhat.com>
	<Pine.LNX.4.63.0609211514470.17238@qynat.qvtvafvgr.pbz>
	<20060921224051.GS26683@redhat.com>
	<Pine.LNX.4.63.0609211530180.17238@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 23:43:43.0734 (UTC) FILETIME=[C610E160:01C6DDD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 15:34:53 -0700 (PDT)
David Lang <dlang@digitalinsight.com> wrote:

> I was responding to the (apparent) argument that with git and ketchup people 
> should not ever be downloading tarballs, so something that cuts the size of a 
> tarball in half doesn't make any difference.

Sure there are some cases where tarballs are more appropriate, but with git
and maybe some of the other tools it should really be the minority situation.
I wonder how many people just use tarballs out of inertia.  All said though
saving a few bytes of bandwidth by making the tarballs smaller can't hurt.

Sean
