Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVCCQ1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVCCQ1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVCCQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:23:49 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56966 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262004AbVCCQXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:23:32 -0500
Message-ID: <422739F6.3090001@nortel.com>
Date: Thu, 03 Mar 2005 10:23:18 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dror Cohen <dror.xiv@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Time Drift Compensation on Linux Clusters
References: <6c58e3190503030650595cbd5@mail.gmail.com>
In-Reply-To: <6c58e3190503030650595cbd5@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dror Cohen wrote:
> Hi all,
> While working on a Linux cluster with kernel version 2.4.27 we've
> encountered a consistent clock drift problem. We have devised a fix
> for this problem which is based on the Pentium's TSC clock.

Any reason why you can't just use NTP?

Chris
