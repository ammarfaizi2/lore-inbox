Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVKVWVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVKVWVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVKVWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:21:51 -0500
Received: from [67.137.28.188] ([67.137.28.188]:9865 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S965065AbVKVWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:21:51 -0500
Message-ID: <43838614.9080807@soleranetworks.com>
Date: Tue, 22 Nov 2005 13:56:52 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: e1000 82571 Packet Splitting
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noted that the e1000 driver is now supporting DMA splitting of 
the packet header and payload into separate pages.  I also noticed
that none of the config options enable it.  Is anyone using this feature 
at present and has it even been tested on Linux? 

Jeff
