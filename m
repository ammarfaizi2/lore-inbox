Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319308AbSIFSh0>; Fri, 6 Sep 2002 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319312AbSIFSh0>; Fri, 6 Sep 2002 14:37:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61062 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319308AbSIFShZ>;
	Fri, 6 Sep 2002 14:37:25 -0400
Date: Fri, 06 Sep 2002 11:34:48 -0700 (PDT)
Message-Id: <20020906.113448.07697441.davem@redhat.com>
To: gh@us.ibm.com
Cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17nNhM-0003PD-00@w-gerrit2>
References: <20020906.103717.82432404.davem@redhat.com>
	<E17nNhM-0003PD-00@w-gerrit2>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerrit Huizenga <gh@us.ibm.com>
   Date: Fri, 06 Sep 2002 11:19:11 -0700
   
   And, honestly, I'm a kernel guy much more than an applications guy, so
   I'll admit that I'm not up to speed on what Tux2 can do with dynamic
   content.

TUX can optimize dynamic content just fine.

   The last I knew was that it could pass it off to another server.

Not true.

   The problem is that performance on Apache sucks
   but people like the features.

Tux's design allows it to be a drop in acceleration method
which does not require you to relinquish Apache's feature set.

