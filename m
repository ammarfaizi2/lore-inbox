Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278395AbRJWXzA>; Tue, 23 Oct 2001 19:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278401AbRJWXyv>; Tue, 23 Oct 2001 19:54:51 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:17198 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S278395AbRJWXym> convert rfc822-to-8bit; Tue, 23 Oct 2001 19:54:42 -0400
Message-Id: <200110232355.TAA07996@smtp10.atl.mindspring.net>
Date: Tue, 23 Oct 2001 19:55:11 -0400 (EDT)
From: Mark Clayton <mark@brown-pelican.com>
Subject: unnumbered interfaces?
To: linux-kernel@vger.kernel.org
X-Mailer: Mahogany, 0.60 'Redmond', compiled for Linux 2.2.16 i686
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to understand unnumbered interfaces.  From 
searching the web, they seem to be point-to-point links 
that do not have IP numbers (hence the name).  This is
what alludes:

 1) How do you set a pair on linux boxes to do this? ppp? 
 2) How would a program send data across the link?  Via
sockets?  Or thru /dev/something0?
 3) Does it make sense that to use ethernet?  Not to me
but sometimes I'm wrong :)

I'm sure I'm missing the obvious.  I usually do.  Can
anyone shed some light on this topic?

Thanks,
Mark
--
Mark & Kathy Clayton
S/V Brown Pelican
http://www.brown-pelican.com/  


