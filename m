Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424572AbWKPVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424572AbWKPVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424622AbWKPVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:07:27 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:61888 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1424572AbWKPVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:07:25 -0500
Message-ID: <455CCFCE.1090306@wolfmountaingroup.com>
Date: Thu, 16 Nov 2006 13:53:34 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.18 X problems with ES4 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If the X server is started manually on 2.6.14 and above with "startx &" 
and if you hit the enter key in the detached session,
the desktop will stop responding to keyboard and mouse events.

It's easy to reproduce.  Set to run level 3 on an ES4, then start the X 
server manually
and hit enter in the session from which you started the gnome desktop, 
and the X server
will stop responding to events, application startup, etc.

It's easisest to reproduce on ES4.

Jeff

