Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285399AbRLNPni>; Fri, 14 Dec 2001 10:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285398AbRLNPn3>; Fri, 14 Dec 2001 10:43:29 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:16323 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S285399AbRLNPnI>; Fri, 14 Dec 2001 10:43:08 -0500
Date: Fri, 14 Dec 2001 16:43:01 +0100
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-Kernel Development Mailinglist 
	<linux-kernel@vger.kernel.org>
Subject: 2.4.17-rc1 doesn't boot (on K6-II)
Message-ID: <20011214164301.A512@Zenith.starcenter>
Mail-Followup-To: Linux-Kernel Development Mailinglist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.17-pre8
X-Telephone: +32 486 460306
X-Requested: Beautiful, smart and Linux-lovin' girlfriend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting 2.4.17-rc1, the following text appears:

-------------------------------------------- BEGIN --
Loading 2.4.17-rc1............. 
Uncompressing Linux...

ran out of input data

  -- System halted
--------------------------------------------- END ---

This has never occured to me before. I'm compiling -rc1 now on another box
(with a different gcc - mine is 2.96-85 - yes, RedHat packaged it) to make
sure this isn't due to gcc.

	Sven Vermeulen

-- 
I would rather spend 10 hours reading someone else's source code than
10 minutes listening to Musak waiting for technical support which 
isn't. ~(Wettstein)
