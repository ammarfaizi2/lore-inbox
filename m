Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVCVPYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVCVPYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCVPYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:24:50 -0500
Received: from bay10-f33.bay10.hotmail.com ([64.4.37.33]:46887 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261371AbVCVPYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:24:13 -0500
Message-ID: <BAY10-F335FA2EF6409398E7CCF3FD64E0@phx.gbl>
X-Originating-IP: [61.247.244.67]
X-Originating-Email: [agovinda04@hotmail.com]
From: "govind raj" <agovinda04@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel-2.4.29 and atheros
Date: Tue, 22 Mar 2005 20:54:07 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 22 Mar 2005 15:24:07.0945 (UTC) FILETIME=[30BB7790:01C52EF3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

kernel version:2.4.29
board :net4521
wireless card : Atheros
diriver  madwifi-cvs-current.tar.bz2

I built the customized image  from 2.4.29 and  booted from this image

The following sequence restarts the board

modprobe ath_pci xchanmode=0
ifup ath0

The board and Atheros work fine up to this point. After this once we give 
the
command

iwconfig

the system gets restarted. No error messages are printed.



Has any one faced this problem before?

What could be the possible cause?


Thanks in advance
  Govind

_________________________________________________________________
Make money with Zero Investment. 
http://adfarm.mediaplex.com/ad/ck/4686-26272-10936-31?ck=RegSell Start your 
business.

