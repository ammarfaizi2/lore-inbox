Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132844AbRDQTjA>; Tue, 17 Apr 2001 15:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132847AbRDQTiv>; Tue, 17 Apr 2001 15:38:51 -0400
Received: from zmailer.org ([194.252.70.162]:4100 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132845AbRDQTiI>;
	Tue, 17 Apr 2001 15:38:08 -0400
Date: Tue, 17 Apr 2001 22:37:47 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Leif Sawyer <lsawyer@gci.com>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Ian.Stirling@tomcat.admin.navo.hpc.mil, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: IP Acounting Idea for 2.5
Message-ID: <20010417223747.M805@mea-ext.zmailer.org>
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA2E@berkeley.gci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF9651D8732ED311A61D00105A9CA3150446DA2E@berkeley.gci.com>; from lsawyer@gci.com on Tue, Apr 17, 2001 at 11:09:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I repeat myself, fighting is apparently so pleasant that you are stuck on
fighting over dead-end technology:

  I seriously suggest that for the primary (subject given) topic
  you are SERIOUSLY OFF TARGET.  Look around, counting hits on
  some fw rules is waste of time!  (And mightly inaccurate!)

  You absolutely don't want to do any sort of counting aggeration policy
  control within kernel ( = FW rules ).   You want to collect accounting
  per flow, and send those data records to offline analysis.

  No more fighting of when to clear counters, and when not.

  Having used (with own custom analyzers) cisco netflow, I can say
  that any sort of "count hits on access-list elements" things are
  from stone-age:

http://www.cisco.com/warp/public/cc/pd/iosw/ioft/neflct/tech/napps_wp.htm


  Yet another nice thing to cook up -- if I had time ...

/Matti Aarnio
