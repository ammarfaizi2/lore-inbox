Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLZCT3>; Wed, 25 Dec 2002 21:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLZCT3>; Wed, 25 Dec 2002 21:19:29 -0500
Received: from user-24-214-12-221.knology.net ([24.214.12.221]:23739 "EHLO
	localdomain") by vger.kernel.org with ESMTP id <S261847AbSLZCT2> convert rfc822-to-8bit;
	Wed, 25 Dec 2002 21:19:28 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ro0tSiEgE <lkml@ro0tsiege.org>
To: linux-kernel@vger.kernel.org
Subject: Mouse Weirdness with HP Notebook
Date: Wed, 25 Dec 2002 20:30:57 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212252030.57004.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my Pavilion ze4145, I'm trying to test the touchpad to see if it works as X 
keeps bombing about my mouse. All I do is a simple "cat /dev/psaux" or "more 
/dev/psaux" and the machine instantly freezes hard. Kernel is 2.4.21-pre2. 
Any ideas?



