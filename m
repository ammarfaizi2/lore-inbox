Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270546AbRHSPIy>; Sun, 19 Aug 2001 11:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270553AbRHSPIo>; Sun, 19 Aug 2001 11:08:44 -0400
Received: from [65.10.228.207] ([65.10.228.207]:54513 "HELO whatever.local")
	by vger.kernel.org with SMTP id <S270546AbRHSPIf>;
	Sun, 19 Aug 2001 11:08:35 -0400
From: chuckw@ieee.org
Date: Sat, 18 Aug 2001 23:17:04 -0400
To: linux-kernel@vger.kernel.org
Subject: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
Message-ID: <20010818231704.A2388@ieee.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
	I was reading the unreliable guide to kernel hacking and was looking for
a little clarification on something.  2 Bottom halves cannot run at the same
time, why?  
	Also, could someone give me an example of a service which is a bottom half/
tasklet/SoftIRQ?

Thanks in advance,
Chuck
