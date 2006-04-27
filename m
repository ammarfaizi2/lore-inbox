Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWD0D5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWD0D5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWD0D5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:57:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:8964 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932417AbWD0D5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:57:37 -0400
Date: Thu, 27 Apr 2006 05:57:09 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Roman Kononov <kononov195-far@yahoo.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: C++ pushback
Message-ID: <20060427035709.GF13027@w.ods.org>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com> <20060426200134.GS25520@lug-owl.de> <Pine.LNX.4.64.0604261305010.3701@g5.osdl.org> <e2ou35$u5r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ou35$u5r$1@sea.gmane.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 06:00:52PM -0500, Roman Kononov wrote:
> Linus Torvalds wrote:
> > - the compilers are slower, and less reliable. This is _less_ of an 
> > issue these days than it used to be (at least the reliability part), 
> >   but it's still true.
> G++ compiling heavy C++ is a bit slower than gcc. The g++ front end is 
> reliable enough. Do you have a particular bug in mind?

Obviously you're not interested in gcc evolutions. I suggest that you
take your browser to http://gcc.gnu.org/gcc-3.4/changes.html#3.4.5
This is the last version which showed per-subsystem problem reports
before they used SVN. Just count the lines : 9 bugs fixed for C, 45
for C++. And when you read those bugs, you don't have the feeling of
reading a description of something that people make their code rely on.

Regards,
Willy

