Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTIMXpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTIMXpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:45:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30412 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262259AbTIMXpm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:45:42 -0400
Date: Sun, 14 Sep 2003 00:45:39 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Discourage Uniform Driver Model?
Message-ID: <20030913234539.GC27151@gallifrey>
References: <200309140027.08610.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309140027.08610.jimwclark@ntlworld.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test3 (i686)
X-Uptime: 00:44:43 up 1 day,  1:23,  1 user,  load average: 0.07, 0.06, 0.06
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Clark (jimwclark@ntlworld.com) wrote:
> If it was possible to create a driver model that allowed module compatibility 
> across different releases/revisions without recompilation and with minimal 
> performance hit would this be desirable? 
> 
> If such a model was possible should development be avoided to discourage 
> binary only modules?

I would argue that is exactly the situation seen by XFree with quite a
few cards requiring binary modules for full functionality.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
