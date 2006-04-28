Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751778AbWD1TZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWD1TZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbWD1TZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:25:59 -0400
Received: from mail2.xor.ch ([212.55.210.166]:40896 "EHLO mail2.xor.ch")
	by vger.kernel.org with ESMTP id S1751778AbWD1TZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:25:58 -0400
Message-ID: <44526C3E.5080200@orpatec.ch>
Date: Fri, 28 Apr 2006 21:25:50 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB-Keyboard through an USB-Switchbox
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2006 19:25:50.0158 (UTC) FILETIME=[8EC90EE0:01C66AF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using now again a second computer with a single USB keyboard through 
an USB switchbox. Switching between computers is equivalent to connect 
and disconnect the USB keyboard rather often. After this 
disconnect/connect I still happen to experience times when the USB stack 
can't synchronize again, leaving me without access to the computer 
(kernel 2.6.12-9). I since I've mentioned this already several years ago 
I though this might be solved but it seems Linux isn't able to build a 
state-of-the-art USB stack which is able to synchronize in _each_ case.

Is there anything I can do to help find out why the USB doesn't work? Is 
there a log anywhere on they system?

O. Wyss

-- 
Cross-platform: http://wyoguide.sf.net/index.php?page=Cross-platform.html

