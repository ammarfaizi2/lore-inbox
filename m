Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWEJWbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWEJWbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEJWbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:31:52 -0400
Received: from mail-relay1.cs.ubc.ca ([142.103.6.79]:12179 "EHLO
	mail-relay1.cs.ubc.ca") by vger.kernel.org with ESMTP
	id S1751511AbWEJWbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:31:51 -0400
Date: Wed, 10 May 2006 15:31:50 -0700 (PDT)
From: Abhishek Gupta <agupta@cs.ubc.ca>
To: linux-kernel@vger.kernel.org
Subject: Determining the size of the buffer cache for individual devices.
Message-ID: <Pine.GSO.4.60.0605101528470.2553@cascade.cs.ubc.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-PMX-Version: 5.0.3.165339, Antispam-Engine: 2.1.0.0, Antispam-Data: 2006.5.10.151112
X-UBCCS-SpamTag: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Does someone know of a way to estimate the instantaneous size of the 
buffer cache for individual devices? For example, if there are two devices 
on your system a)/dev/hda1 and b)/dev/hda2 and each is running a different 
workload. How can we calculate the amount of cache being used by each 
devices individually?

Please advise. Thanks.

Abhishek
