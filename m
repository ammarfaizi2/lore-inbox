Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSJQXeY>; Thu, 17 Oct 2002 19:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbSJQXeX>; Thu, 17 Oct 2002 19:34:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37056 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262289AbSJQXeO>;
	Thu, 17 Oct 2002 19:34:14 -0400
Date: Thu, 17 Oct 2002 16:32:36 -0700 (PDT)
Message-Id: <20021017.163236.101134627.davem@redhat.com>
To: scott.feldman@intel.com
Cc: roy@karlsbakk.net, linux-kernel@vger.kernel.org, manand@us.ibm.com
Subject: Re: TCP Segmentation Offload (TSO) in 2.4?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <288F9BF66CD9D5118DF400508B68C44604758BCE@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C44604758BCE@orsmsx113.jf.intel.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Feldman, Scott" <scott.feldman@intel.com>
   Date: Thu, 17 Oct 2002 16:35:18 -0700

   > 1) You'll only get this with e1000 cards, and there were some
   >    performance regression noted by some testers at IBM with
   >    TSO enabled.
   
   Was this posted to the list?  I remember Troy's results showing positive
   results with TSO over SPECWeb.  
   
Mala Anand (manand@us.ibm.com) has continually been disabling TSO in
2.5.x performance tests, at least this is how it has appeared to me.

Please, you two have a dialogue together and sort this out :-)
