Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319331AbSIFSvC>; Fri, 6 Sep 2002 14:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319332AbSIFSvC>; Fri, 6 Sep 2002 14:51:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14471 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319331AbSIFSvB>;
	Fri, 6 Sep 2002 14:51:01 -0400
Date: Fri, 06 Sep 2002 11:48:15 -0700 (PDT)
Message-Id: <20020906.114815.127906065.davem@redhat.com>
To: Martin.Bligh@us.ibm.com
Cc: gh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61930391.1031313088@[10.10.2.3]>
References: <20020906.113611.102227888.davem@redhat.com>
	<61930391.1031313088@[10.10.2.3]>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
   Date: Fri, 06 Sep 2002 11:51:29 -0700
   
   I see no reason why turning on NAPI should make the Apache setup
   we have perform worse ... quite the opposite. Yes, we could use
   Tux, yes we'd get better results. But that's not the point ;-)

Of course.

I just don't want propaganda being spread that using Tux means you
lose any sort of web server functionality whatsoever.
