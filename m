Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVG0W2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVG0W2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVG0WWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:22:20 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:22732 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S261201AbVG0WUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:20:02 -0400
Date: Thu, 28 Jul 2005 00:22:44 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: system freezes for 0.2 to 0.5 seconds when reading
 /proc/acpi/thermal_zone/THRM/temperature
Message-ID: <20050728002244.5163ac4a@localhost>
X-Mailer: Sylpheed-Claws 1.9.13cvs2 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all, sorry for the long headline.
second:
Every time, i try to do the following:
cat /proc/acpi/thermal_zone/THRM/temperature
the whole system looks up for a short period of time (something about
0.5s). realy everything, video and audio encoding, mouse and keyboard
input, firefox playing a flash animation, ...
I am also getting the following:
Losing some ticks... checking if CPU frequency changed.

maybe these two things are belonging to each other.

I am using a 2.6.12-rc3-mm1 kernel on a amd64 with a nvidia nforce4
mainboard.


kind regards

flo

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
