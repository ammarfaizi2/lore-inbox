Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277580AbRJLI2P>; Fri, 12 Oct 2001 04:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277581AbRJLI2F>; Fri, 12 Oct 2001 04:28:05 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:8134 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277580AbRJLI1q>;
	Fri, 12 Oct 2001 04:27:46 -0400
Date: Fri, 12 Oct 2001 09:28:12 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Peter Rival <frival@zk3.dec.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>, cardoza@zk3.dec.com,
        woodward@zk3.dec.com,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with
Message-ID: <946453649.1002878892@[195.224.237.69]>
In-Reply-To: <200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
In-Reply-To: <200110120543.f9C5hvZ224264@saturn.cs.uml.edu>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, 12 October, 2001 1:43 AM -0400 "Albert D. Cahalan" 
<acahalan@cs.uml.edu> wrote:

> There is a memory barrier instruction called "eieio"

This must be April 1 by some calendar.

With a read/write here, a read/write there... (etc.)

Guess the engineer was called Mr/Ms McDonald.

--
Alex Bligh
