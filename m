Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbUDLLoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 07:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUDLLoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 07:44:34 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:42302 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262863AbUDLLod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 07:44:33 -0400
Message-ID: <407A8121.8050903@blueyonder.co.uk>
Date: Mon, 12 Apr 2004 12:44:33 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: problems getting the modules in the right order
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2004 11:44:34.0217 (UTC) FILETIME=[867A1990:01C42083]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Radeon 9600 Mobility in my laptop and it boots into KDE on SuSE 
9.0 x86_64.
CONFIG_DRM_RADEON=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_DEBUG=y
CONFIG_AGP_AMD64=y
I still see failed messages in starting services which is some race 
condition I've not yet fathomed, but the services are all running. Up on 
2.6.5-mm4.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

