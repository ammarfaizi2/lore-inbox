Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbTC3SgN>; Sun, 30 Mar 2003 13:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbTC3SgN>; Sun, 30 Mar 2003 13:36:13 -0500
Received: from the-penguin.otak.com ([65.37.126.18]:20154 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S261511AbTC3SgM>; Sun, 30 Mar 2003 13:36:12 -0500
Date: Sun, 30 Mar 2003 10:47:56 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: MCE error
Message-ID: <20030330184756.GA22307@the-penguin.otak.com>
Mail-Followup-To: Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.5.65 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a MCE error while running 2.5.65 "MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 2: 940040000000017a" did a google search and found Dave Jones's parsemce, and decoded it to

Status: (ba) Error IP valid
Restart IP invalid.

And was wondering what that actually meant. :) 
Really what I need to know is, how non fatal is non fatal?


-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


