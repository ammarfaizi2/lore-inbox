Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWGSF2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWGSF2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 01:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWGSF2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 01:28:12 -0400
Received: from ctb-mesg4.saix.net ([196.25.240.74]:58816 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S932500AbWGSF2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 01:28:12 -0400
Message-ID: <44BDC2E8.4090502@geograph.co.za>
Date: Wed, 19 Jul 2006 07:28:08 +0200
From: Zoltan Szecsei <zoltans@geograph.co.za>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: pci related memory allocation errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I keep getting the following message at boot time:

[17179570.320000] PCI: Failed to allocate mem resource #6:20000@90000000 
for 0000:01:00.0

Why is this?


TIA,
Zoltan


