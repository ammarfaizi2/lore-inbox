Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313796AbSDPR5c>; Tue, 16 Apr 2002 13:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313799AbSDPR5b>; Tue, 16 Apr 2002 13:57:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51861 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313796AbSDPR5a>;
	Tue, 16 Apr 2002 13:57:30 -0400
Date: Tue, 16 Apr 2002 10:49:21 -0700 (PDT)
Message-Id: <20020416.104921.95902105.davem@redhat.com>
To: haveblue@us.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ips driver compile problems
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CBC3DB5.7020709@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Hansen <haveblue@us.ibm.com>
   Date: Tue, 16 Apr 2002 08:05:25 -0700

      This patch has been floating inside IBM for a bit, but it appears 
   that no one passed it back up to you, yet.  I don't know who wrote it, 
   but it applies to 2.5.8 and the ServeRAID driver works just fine with it 
   applied.  Without it, the driver fails to compile.

Alan commented today on this list why these changes are not
acceptable.
