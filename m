Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317331AbSGOFet>; Mon, 15 Jul 2002 01:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSGOFes>; Mon, 15 Jul 2002 01:34:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7107 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317331AbSGOFer>;
	Mon, 15 Jul 2002 01:34:47 -0400
Date: Sun, 14 Jul 2002 22:28:20 -0700 (PDT)
Message-Id: <20020714.222820.132929128.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [sparc32] reserve nocache based on RAM size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020714153804.GA8783@louise.pinerecords.com>
References: <20020714153804.GA8783@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 14 Jul 2002 17:38:05 +0200

   Since there's no official sparc32 maintainer, I'm sending this patch
   directly to you. It has now been tested in various configurations
   (released in the default Aurora 0.3 kernel) and appears to be causing
   no undesired side effects.

I'm still reviewing the patch and it is in my backlog AND I was on a
12 day vacation.  Be patient and I didn't want this in until 2.4.20
anyways, thanks.
