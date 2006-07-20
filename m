Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWGTIQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWGTIQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 04:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWGTIQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 04:16:50 -0400
Received: from sandesha.sasken.com ([164.164.56.19]:4272 "EHLO
	mail3.sasken.com") by vger.kernel.org with ESMTP id S964903AbWGTIQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 04:16:49 -0400
Date: Thu, 20 Jul 2006 13:46:41 +0530 (IST)
From: Subbu <subbu@sasken.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
cc: subbu2k_av@yahoo.com
Subject: Memory allocation Failure problem with kmalloc.
In-Reply-To: <Pine.GSO.4.64.0607171557040.15797@sunm21.sasken.com>
Message-ID: <Pine.GSO.4.64.0607201340580.13879@sunm21.sasken.com>
References: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com><Pine.GSO.4.
	64.0607171557040.15797@sunm21.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset=US-ASCII;
	format=flowed
X-imss-version: 2.037
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:3 C:2 M:3 S:3 R:3 (0.5000 0.5000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

   I am working on 2.4.20 kernel.

   I need to allocate memory with kmalloc.

   kmalloc fails because i want to allocate more than 128kb. How to handle 
this issue.

   Please help me in this regard.

   How i can allocate memory of size equal to 1Mb with kmalloc or any other 
function (2.4 kernel)

THanx in advance.
Subbu


"SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"

                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
