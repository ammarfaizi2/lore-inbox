Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSFQFdZ>; Mon, 17 Jun 2002 01:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSFQFdY>; Mon, 17 Jun 2002 01:33:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56466 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316753AbSFQFdX>;
	Mon, 17 Jun 2002 01:33:23 -0400
Date: Sun, 16 Jun 2002 22:28:13 -0700 (PDT)
Message-Id: <20020616.222813.04502396.davem@redhat.com>
To: rml@mvista.com
Cc: mingo@elte.hu, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1024271149.3090.13.camel@sinai>
References: <Pine.LNX.4.44.0206161710240.7461-100000@e2>
	<1024271149.3090.13.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@mvista.com>
   Date: 16 Jun 2002 16:45:45 -0700
   
   My approach thus far with 2.5 -> 2.4 O(1) backports has been one of
   caution and it has worked fine thus far.  I figure, what is the rush?

Your changes were pretty, that's part of the problem.  Fixing things
correctly is 10 times more preferable to a 1 time hack "just for now".

