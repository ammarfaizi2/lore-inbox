Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRLLX3e>; Wed, 12 Dec 2001 18:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282882AbRLLX3Y>; Wed, 12 Dec 2001 18:29:24 -0500
Received: from cpw.math.columbia.edu ([128.59.209.25]:7319 "EHLO
	cpw.math.columbia.edu") by vger.kernel.org with ESMTP
	id <S282880AbRLLX3P>; Wed, 12 Dec 2001 18:29:15 -0500
Date: Wed, 12 Dec 2001 18:29:17 -0500 (EST)
From: Alp ATICI <atici@math.columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: Network related
Message-ID: <Pine.LNX.4.40.0112121821260.4894-100000@intel4.math.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a problem with the 2.4.14 kernel custom compiled on a RedHat 7.2. I
thought I was very careful in selecting the necessary modules at first.
Everything works great except that when I want to browse some sites
I get a "connection timed out". Most of the sites work ok but some
specific ones like www.nvidia.com, www.sun.com, www.ingdirect.com
never works and gives the same error. When I boot up with other
kernel or win2000 everything works fine though:( Maybe this is
a consequence of some other bigger problem which I couldn't figure
out so far. It looks like only those sites filter out my http request.
What modules could I have forgotten to include?

Another question is I don't have ipt_MIRROR, ipt_unclean, ipt_iplimit
in netfilter modules anymore. What config settings should I set on
to have these back?
Thanks a lot,
Alp

