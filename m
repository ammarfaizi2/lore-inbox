Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSFZG0m>; Wed, 26 Jun 2002 02:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSFZG0l>; Wed, 26 Jun 2002 02:26:41 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:40849 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316430AbSFZG0l>; Wed, 26 Jun 2002 02:26:41 -0400
From: Simon Winwood <sjw@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2002 16:26:37 +1000
Subject: [RFC][PATCH] Multiple page size support
Message-ID: <20020626162636.A12854@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	In preperation for the talk at this years OLS, I have put up 
my page size patch at http://www.cse.unsw.edu.au/~sjw/linux-mpss/
(the actual patch is 
    
    http://www.cse.unsw.edu.au/~sjw/linux-mpss/linux-2.4.18-mpss-0.1 
)

	This patch allows applications to map parts of their
address space using large pages, currently only on an x86 (ports 
to other architectures are planned).

	While this is still definately a work in progress, and in no way 
ready for consideration for a production kernel, I would be interested in 
any (constructive) criticism people may have.  

	The work was done while I was an intern in the Enterprise Linux
Group at IBM's T.J. Watson Research Center.

	(The usual disclaimers apply --- I take no responsibility if this
causes any damage to you, your computer, your social life, etc.)

	I will put up a copy of the OLS paper and slides after the talk.

	Simon
