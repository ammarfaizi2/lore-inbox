Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265969AbRF1OeG>; Thu, 28 Jun 2001 10:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265967AbRF1Od5>; Thu, 28 Jun 2001 10:33:57 -0400
Received: from POBOX.UPENN.EDU ([128.91.2.38]:62724 "EHLO pobox.upenn.edu")
	by vger.kernel.org with ESMTP id <S265972AbRF1Odq>;
	Thu, 28 Jun 2001 10:33:46 -0400
From: Michael J Clark <clarkmic@pobox.upenn.edu>
Message-Id: <200106281433.f5SEXk800876@pobox.upenn.edu>
Subject: TCP/IP stack
To: linux-kernel@vger.kernel.org
Date: Thu, 28 Jun 2001 10:33:46 -0400 (EDT)
X-Mailer: ELM [version 2.4 PL23-upenn3.3]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey guys,

I have been reading through TCP/IP Illustrated Vol 2 and the linux 
source.  I am having a heck of a time finding where it sees a SYN packet 
and check to see if the desitination port is open.  In the book it looks 
like it happens in tcp_input where it looks for the PCB for a segment.  
Any pointers would be greatly appeciated.

Mike
