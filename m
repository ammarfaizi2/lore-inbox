Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132737AbRDLHiD>; Thu, 12 Apr 2001 03:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132912AbRDLHhy>; Thu, 12 Apr 2001 03:37:54 -0400
Received: from [217.57.75.5] ([217.57.75.5]:16116 "HELO newton.ascensit.it")
	by vger.kernel.org with SMTP id <S132737AbRDLHhk>;
	Thu, 12 Apr 2001 03:37:40 -0400
Date: Thu, 12 Apr 2001 09:37:37 +0200
From: Cristian Prevedello <plasma@ascensit.com>
To: linux-kernel@vger.kernel.org
Subject: Network Classifier Performance
Message-ID: <20010412093737.A1470@ascensit.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
X-Operating-System: Linux newton 2.4.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here you are my today doubt:

setting up a traffic shaper with a linux box is very easy and after this
you have in your hands a powerful toy. Of course, due the great flexibility of
linux networking system there are many ways to achieve your goal.
In particular, which is the boost you gain if you classify your network traffic
throught hash tables instead marking the traffic with iptables (or ipchains)
and later using the fw classifier?
I'm asking this since marking traffice with iptables is much more easier and
takes less time, while using u32 filter is more complex and requires more
knowledge. It's true u32 is much much more powerful..but it's a matter of
trade off.

-- 
Cristian Prevedello, Consulente presso Ascensit srl
plasma@ascensit.com, http://www.ascensit.com/
