Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264604AbUDVSth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUDVSth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUDVStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:49:36 -0400
Received: from www.amthinking.net ([65.104.119.37]:15919 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP id S264604AbUDVStf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:49:35 -0400
Message-ID: <408813B0.6000806@appliedminds.com>
Date: Thu, 22 Apr 2004 11:49:20 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: miller@techsource.com
Subject: Re: New Radeonfb (2.6.5) driver does not play nice with X (4.3.0)
References: <4087EB5A.7040404@appliedminds.com>
In-Reply-To: <4087EB5A.7040404@appliedminds.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2004 18:49:34.0152 (UTC) FILETIME=[8DC0E480:01C4289A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
 > Are you using ATI's proprietary drivers? I have also experienced this
 > sort of system hang when using their drivers. When I would exit the X
 > server, I would get a screen full of vertical lines and the system
 > would be completely dead (could not ping).

 > The short-term solutions are either to use the XFree's native drivers
 > or to use vesafb for the console. The long term solution is for ATI to
 > fix their drivers.

Well I did try with Driver "vga" (I had been using the ATI proprietary
ones), and it still exhibited the same behavior.
	

-- 
James Lamanna
