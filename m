Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269688AbUISBv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbUISBv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 21:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269690AbUISBv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 21:51:27 -0400
Received: from web52803.mail.yahoo.com ([206.190.39.167]:21654 "HELO
	web52803.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269688AbUISBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 21:51:25 -0400
Message-ID: <20040919015125.32796.qmail@web52803.mail.yahoo.com>
Date: Sat, 18 Sep 2004 18:51:24 -0700 (PDT)
From: mike cox <mikecoxlinux@yahoo.com>
Subject: Logitech and Microsoft Tilt Wheel Mice. Driver suggestions wanted.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm modifying Vojtech Pavlik's 2.6.8.1 kernel
mousedev.c mouse driver to support the new "Tilt
wheel" functionality on the Logitech MX1000 Laser
Mouse, and the Microsoft Wireless Optical mouse with
Tilt Wheel Technology.

I have some alpha code already worked out that
compiles with the 2.6.8.1 kernel, but before I submit
it, I'd like some suggestions on how others would like
to see it implemented.  

The Tilt wheel is basically a scroll wheel that tilts
left and right enabling the user to scroll left and
right.  

Please CC your responses and suggestions as my email
account cannot manage the size of the KML.

Thank you all.  

P.S.  If you want to see what I have so far, please
respond and I'll happily email you the code or post it
to klm.


		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
