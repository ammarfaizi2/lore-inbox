Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTJASUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTJASUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:20:52 -0400
Received: from alias-3.uta.edu ([129.107.56.12]:3770 "EHLO alias-3.uta.edu")
	by vger.kernel.org with ESMTP id S261941AbTJASUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:20:51 -0400
Date: Wed, 1 Oct 2003 13:20:45 -0500 (CDT)
From: Anoop Rajendra <axr3845@omega.uta.edu>
To: linux-kernel@vger.kernel.org
Subject: Problem using PCMCIA card on 2.6.0-test5
Message-ID: <Pine.OSF.4.51.0310011313110.31478@omega.uta.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have problems using the wireless card on my laptop.
It uses the acx100sta chipset :-(. But thats not the problem.
Every time I insert the card the kernel prints out a message
saying kernel unable to handle paging request. And if I try to
remove the card the system hangs. For the card I'm using the yenta_socket
module in the kernel.The i82365 module does not work. This isnt a driver
problem, because I havent even loaded the drivers.(i actually dont have
'em for this kernel)
Any ideas?
Thanks,
Anoop
