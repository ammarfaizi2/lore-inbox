Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTGGKo7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264887AbTGGKo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:44:59 -0400
Received: from vsmtp1.tin.it ([212.216.176.221]:34516 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S264879AbTGGKo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:44:58 -0400
Date: Mon, 7 Jul 2003 13:02:28 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: VESAFB doesn't accept command-line Option
From: Lia Maggioni <voloterreno@tin.it>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <801D7684-B06A-11D7-804B-00039387DFA2@tin.it>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I use Linux Kernel 2.4.21 vanilla version , and I have this problem.

I'd like to use the YWRAP option for VESAFB in order to speedup a bit 
the framebuffer , so I pass the "video=vesa:ywrap" option at the command 
line (i've tried to pass it manually and with lilo append="" ) but the 
framebuffer still using the REDRAW function , and does not respond to my 
commands . I've tried kernel 2.4.18 and it works correctly , and with 
2.4.20 it works correctly too , but with 2.4.21 series (i've tried 
2.4.21-ac4 too) doesn't works.

Thank u very much for your help

Bye

Marcello

