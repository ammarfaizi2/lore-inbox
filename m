Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274692AbRITXAn>; Thu, 20 Sep 2001 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274689AbRITXAd>; Thu, 20 Sep 2001 19:00:33 -0400
Received: from kiln.isn.net ([198.167.161.1]:18800 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S274692AbRITXA1>;
	Thu, 20 Sep 2001 19:00:27 -0400
Message-ID: <3BAA74B4.63243DDF@isn.net>
Date: Thu, 20 Sep 2001 19:59:00 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: VM or Netscape problem?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This could be a long standing bug as it is difficult to reproduce.
Periodically Netscape(4.75) will tell me that it cannot find anybody,
including my mail server. This is after it has already been there in the
same session. Quitting Netscape and restarting fixes the problem. When I
see this and think to look at free, I find that I am just into swap a
few Mb. I'm wondering if VM could be kicking out part of Netscape and
not getting it back (in time). I have also had the box lockup switching
back to X from a text VT and the problems could be related.
Currently on pre12.
cc
Garst
