Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262247AbRENERN>; Mon, 14 May 2001 00:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbRENERD>; Mon, 14 May 2001 00:17:03 -0400
Received: from ns.snowman.net ([63.80.4.34]:52746 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S262247AbRENEQu>;
	Mon, 14 May 2001 00:16:50 -0400
Date: Mon, 14 May 2001 00:16:50 -0400 (EDT)
From: <nick@snowman.net>
To: linux-kernel@vger.kernel.org
Subject: Minor nit to pick
Message-ID: <Pine.LNX.4.21.0105140014530.20415-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'd like to fix a minor nit I've had with linux for a while, however I
need a bit more information, and would like to know if a patch would be
accepted.  After running make menuconfig (and it's friends) you get told
to type "make bzImage" which is only right for i386, and IMHO should be
changed to be arch dependant.  Has anyone done this, does anyone have a
recommendation as to how, or failing both those two, can I get a complete
list of the correct "make blah" lines for each arch?
	Thanks
		Nick

