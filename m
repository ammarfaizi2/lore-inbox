Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130338AbRACN0F>; Wed, 3 Jan 2001 08:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbRACNZ4>; Wed, 3 Jan 2001 08:25:56 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:8455 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S130338AbRACNZl>; Wed, 3 Jan 2001 08:25:41 -0500
Date: Wed, 3 Jan 2001 12:55:02 +0000 (GMT)
From: "Dr. David Gilbert" <gilbertd@treblig.org>
To: <linux-kernel@vger.kernel.org>
Subject: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I got wondering as to whether the various journaling file system
activities were designed to survive the occasional unclean shutdown or
were designed to allow the user to just pull the plug as a regular means
of shutting down.

  Thoughts?

Dave

-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
