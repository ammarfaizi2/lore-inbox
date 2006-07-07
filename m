Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGGK7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGGK7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGGK7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:59:07 -0400
Received: from sandesha.sasken.com ([164.164.56.19]:46750 "EHLO
	mail3.sasken.com") by vger.kernel.org with ESMTP id S932127AbWGGK7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:59:05 -0400
Date: Fri, 7 Jul 2006 16:28:45 +0530 (IST)
From: Subbu <subbu@sasken.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
cc: subbu2k_av@yahoo.com
Subject: kernel thread priority
Message-ID: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset=US-ASCII;
	format=flowed
X-imss-version: 2.037
X-imss-result: Passed
X-imss-scores: Clean:46.83769 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:2 M:3 S:3 R:3 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

     I have to run some part of my network driver code in a thread which 
should have highest priority.

     I am working on 2.4.20-8 redhat 9 kernel version.

     i am using kernel_thread function to run the current process in a
thread.

     How can i set the priority level of the same to the highest .

     please help me in this regard. what are the functions i should use
for this


   Thanx in advance
   subbu



"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
