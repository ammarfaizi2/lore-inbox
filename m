Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312421AbSCYNhV>; Mon, 25 Mar 2002 08:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312422AbSCYNhE>; Mon, 25 Mar 2002 08:37:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24076 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S312421AbSCYNg6>; Mon, 25 Mar 2002 08:36:58 -0500
Date: Mon, 25 Mar 2002 14:36:55 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: patrol@tangens.sinus.cz
Subject: USB/devfs problem
Message-ID: <20020325133655.GI14507@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I have a friend who connects his digital camera to computer via USB. In 2.4.17
everything worked ok but in 2.4.18 the device is detected by USB, SCSI prints
message about the device but no entries are created in /dev (he uses devfs). Also
when the camera is disconnected from the computer or when it's connected again
no message appears. Does anybody know where could be the problem?

								Thanks
									Honza

