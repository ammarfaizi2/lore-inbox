Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264898AbSIRBbl>; Tue, 17 Sep 2002 21:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSIRBbl>; Tue, 17 Sep 2002 21:31:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45189 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264898AbSIRBbk>;
	Tue, 17 Sep 2002 21:31:40 -0400
Date: Tue, 17 Sep 2002 18:27:22 -0700 (PDT)
Message-Id: <20020917.182722.122084128.davem@redhat.com>
To: wli@holomorphy.com
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020918002240.GB2179@holomorphy.com>
References: <Pine.LNX.4.44.0209180024090.30913-100000@localhost.localdomain>
	<20020918002240.GB2179@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Tue, 17 Sep 2002 17:22:40 -0700
   
   The issues addressed here are extremely important for the workloads I
   must support.

Have you published test tools that emulate your workload?
These would be very useful, probably to find problems even
outside the scope of pid lookups.
