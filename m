Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132255AbRCZAXx>; Sun, 25 Mar 2001 19:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132256AbRCZAXm>; Sun, 25 Mar 2001 19:23:42 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:47892 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S132255AbRCZAXj>; Sun, 25 Mar 2001 19:23:39 -0500
Subject: swap file vs swap partition
From: Robert "M." Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.9+cvs.2001.03.25.09.06 (Preview Release)
Date: 25 Mar 2001 19:23:02 -0500
Message-Id: <985566184.20461.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel 2.4.2-ac24.

first, i have 256MB of RAM and a 128MB swap. i know the recommendation
is RAM*2 for swap, but is that a *requirement* as well? i understand the
active/inactive page debate and why *2 is needed (lets not argue that),
but am i just wasting space with a 128MB swap?

second, is there any performance issues with a swap partition vs a swap
file. without resizing, i am stuck with the 128mb partition.

thanks,


-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

