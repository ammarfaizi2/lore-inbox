Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRB1J5o>; Wed, 28 Feb 2001 04:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRB1J5Y>; Wed, 28 Feb 2001 04:57:24 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:22681 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S129534AbRB1J5P>; Wed, 28 Feb 2001 04:57:15 -0500
Message-ID: <3A9CCA76.3E6AB93A@optushome.com.au>
Date: Wed, 28 Feb 2001 20:52:54 +1100
From: Glenn McGrath <bug1@optushome.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: devfs and /proc/ide/hda
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im running kernel 2.4.1, I have entries like /proc/ide/hda,
/proc/ide/ide0/hda etc irrespective of wether im using devfs or
traditional device names.

Is always using traditional device names for /proc/ide intentional, or
is it something nobody has gotten around to fixing yet?


Glenn
