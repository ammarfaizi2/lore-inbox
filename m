Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRCAK3t>; Thu, 1 Mar 2001 05:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129271AbRCAK3j>; Thu, 1 Mar 2001 05:29:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129199AbRCAK3e>; Thu, 1 Mar 2001 05:29:34 -0500
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
To: reiser@namesys.com (Hans Reiser)
Date: Thu, 1 Mar 2001 10:32:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3A9D891C.434E3AA7@namesys.com> from "Hans Reiser" at Mar 01, 2001 02:26:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YQO0-0007cl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> They know that iMimic's polymix performance on Linux 2.2.* is half what it is on
> BSD.  Has the Linux 2.4 networking code caught up to BSD?

For the general case its been the same sort of speed as BSD sometimes faster
sometimes not since before 2.2. So the problem they see would need more
analysis to understand the real cause

