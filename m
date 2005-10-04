Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVJDNAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVJDNAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVJDNAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:00:10 -0400
Received: from free.hands.com ([83.142.228.128]:8582 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932422AbVJDNAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:00:07 -0400
Date: Tue, 4 Oct 2005 13:59:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chase Venters <chase.venters@clientec.com>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051004125955.GQ10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <54300000.1128297891@[10.10.2.4]> <20051003011041.GN6290@lkcl.net> <200510022028.07930.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510022028.07930.chase.venters@clientec.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 08:27:45PM -0500, Chase Venters wrote:

> The bottom line is that the application developers need to start being clever 
> with threads. 

 yep!  ah.  but.  see this:

 http://lists.samba.org/archive/samba-technical/2004-December/038300.html

 and think what would happen if glibc had hardware-support for
 semaphores and mutexes.

> I think I remember some interesting rumors about Perl 6, for 
> example, including 'autothreading' support - the idea that your optimizer 
> could be smart enough to identify certain work that can go parallel.

 http://www.ics.ele.tue.nl/~sander/publications.php
 http://portal.acm.org/citation.cfm?id=582068
 http://csdl.computer.org/comp/proceedings/acsd/2003/1887/00/18870237.pdf

 to get the above references, put in "holland parallel code
 analysis tools" into google.com.

 put in "parallel code analysis tools" into google.com for a different
 set.

 l.


