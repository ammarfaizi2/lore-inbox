Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293577AbSCKCgF>; Sun, 10 Mar 2002 21:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293576AbSCKCf4>; Sun, 10 Mar 2002 21:35:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:5306 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293558AbSCKCfg>;
	Sun, 10 Mar 2002 21:35:36 -0500
Date: Sun, 10 Mar 2002 18:32:20 -0800 (PST)
Message-Id: <20020310.183220.31058484.davem@redhat.com>
To: mfedyk@matchmail.com
Cc: bcrl@redhat.com, whitney@math.berkeley.edu, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020311022821.GB311@matchmail.com>
In-Reply-To: <20020310.180456.91344522.davem@redhat.com>
	<20020310212210.A27870@redhat.com>
	<20020311022821.GB311@matchmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mike Fedyk <mfedyk@matchmail.com>
   Date: Sun, 10 Mar 2002 18:28:21 -0800
   
   What is happening with NAPI anyway?
   
Pending inclusion into 2.5.x once I get my existing networking patches
pushed to Linus first.

It may be backported to 2.4.x one day, but I personally don't think
that is such a great idea for the time being.  Maybe in a month or
two, but not right now.
