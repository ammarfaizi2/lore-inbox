Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWC2Tof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWC2Tof (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWC2Tof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:44:35 -0500
Received: from zrtps0kn.nortel.com ([47.140.192.55]:41900 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750887AbWC2Toe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:44:34 -0500
Message-ID: <442AE395.8000402@nortel.com>
Date: Wed, 29 Mar 2006 13:44:21 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_FRAME_POINTER and module vermagic
References: <442ACAD6.6@nortel.com> <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603291308240.28274@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2006 19:44:22.0852 (UTC) FILETIME=[2D9C3040:01C65369]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:

> Frame-pointers don't affect calling conventions, only the manner
> at which passed parameters are retrieved from the stack by the
> called procedures.

Excellent.  Thanks for the information.

Chris

