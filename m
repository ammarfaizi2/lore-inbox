Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSCLLTK>; Tue, 12 Mar 2002 06:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293531AbSCLLSw>; Tue, 12 Mar 2002 06:18:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37577 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292385AbSCLLSk>;
	Tue, 12 Mar 2002 06:18:40 -0500
Date: Tue, 12 Mar 2002 03:15:09 -0800 (PST)
Message-Id: <20020312.031509.53067416.davem@redhat.com>
To: michael@metaparadigm.com
Cc: bcrl@redhat.com, whitney@math.berkeley.edu, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [patch] ns83820 0.17
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com>
In-Reply-To: <20020312004036.A3441@redhat.com>
	<51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Michael Clark <michael@metaparadigm.com>
   Date: Tue, 12 Mar 2002 19:00:09 +0800

   Dave, what performance do you get with the sk98 using normal size
   frames? (to compare apples with apples). BTW - i can't try jumbo
   frames due to my crappy 3com gig switch.

Use a cross-over cable to play with Jumbo frames, that is
what I do :-)

Later this week I'll rerun tests on all the cards I have
(Acenic, Sk98, tigon3, Natsemi etc.) with current drivers
to see what it looks like with both jumbo and non-jumbo
mtus over gigabit.
