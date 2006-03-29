Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWC2I0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWC2I0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 03:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWC2I0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 03:26:04 -0500
Received: from mx.ininfo.com.ua ([212.26.159.7]:31718 "EHLO mx.ininfo.com.ua")
	by vger.kernel.org with ESMTP id S1750712AbWC2I0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 03:26:03 -0500
Message-ID: <442A4498.9060304@ininfo.com.ua>
Date: Wed, 29 Mar 2006 11:26:00 +0300
From: artem <artem@ininfo.com.ua>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i2c
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Does anyone now, what has happend. Since kernel 2.6.14 I experience
problems with kernel:
1) I have tvtuner (SAA7134). When switching channels, sound disappear
for a while and then appear (I think that problem is in trying to found
stereo), using 2.6.12 it's OK
2) My IR (on tvtuner) work worse (have delay,before it begin to react
on keypress)
All my suspicions are on i2c

