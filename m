Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFJMXL>; Mon, 10 Jun 2002 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSFJMXJ>; Mon, 10 Jun 2002 08:23:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312560AbSFJMXF>;
	Mon, 10 Jun 2002 08:23:05 -0400
Date: Mon, 10 Jun 2002 05:18:57 -0700 (PDT)
Message-Id: <20020610.051857.97850707.davem@redhat.com>
To: ltd@cisco.com
Cc: greearb@candelatech.com, mark@mark.mielke.cc, cfriesen@nortelnetworks.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: RFC: per-socket statistics on received/dropped packets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20020610220015.040aff60@mira-sjcm-3.cisco.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Lincoln Dale <ltd@cisco.com>
   Date: Mon, 10 Jun 2002 22:03:25 +1000
   
   would you be willing to accept a patch that enables per-socket
   accounting with a CONFIG_ option?

What is the point?

If all the dists will enable it then everybody eats the overhead.
If the dists don't enable it, how useful is it and what's so wrong
with it being an external patch people just apply when they need to
diagnose something like this?

