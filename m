Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319318AbSIFSje>; Fri, 6 Sep 2002 14:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319320AbSIFSje>; Fri, 6 Sep 2002 14:39:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1159 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319318AbSIFSjd>;
	Fri, 6 Sep 2002 14:39:33 -0400
Date: Fri, 06 Sep 2002 11:36:52 -0700 (PDT)
Message-Id: <20020906.113652.40767574.davem@redhat.com>
To: haveblue@us.ibm.com
Cc: ak@suse.de, Martin.Bligh@us.ibm.com, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D78F4E6.3020101@us.ibm.com>
References: <3D78E7A5.7050306@us.ibm.com>
	<20020906202646.A2185@wotan.suse.de>
	<3D78F4E6.3020101@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Hansen <haveblue@us.ibm.com>
   Date: Fri, 06 Sep 2002 11:33:10 -0700
   
   Actually, oprofile separated out the acenic module from the rest of the 
   kernel.  I should have included that breakout as well. but it was only 1.3 
   of CPU:
   1.3801 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o

We thought you were using e1000 in these tests?
