Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbTCYP0U>; Tue, 25 Mar 2003 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262683AbTCYP0U>; Tue, 25 Mar 2003 10:26:20 -0500
Received: from cuculus.hub.gts.cz ([195.39.57.22]:64522 "EHLO
	cuculus.switch.gts.cz") by vger.kernel.org with ESMTP
	id <S262682AbTCYP0T>; Tue, 25 Mar 2003 10:26:19 -0500
Date: Tue, 25 Mar 2003 16:37:30 +0100
From: Petr Cisar <pc@cuculus.switch.gts.cz>
To: linux-kernel@vger.kernel.org
Subject: Strange cursor behaviour in Radeon 8500 fb console in 2.5.66
Message-ID: <20030325163730.A11957@cuculus.switch.gts.cz>
Reply-To: Petr Cisar <petr.cisar@gtsgroup.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since (I guess) 2.5.58, there have been problems with cursor in Radeon framebuffer console. In the previous versions the cursor was nat visible at all. Now (in 2.5.66) it blinks iregularily and at times it changes shape and color (it seems that something writes in the cursor's image).

Has anyone experienced the same and aren't there any patches ?

Regards

Petr
