Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDOPx3 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDOPx3 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:53:29 -0400
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:52758
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id S261706AbTDOPx2 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 11:53:28 -0400
Message-ID: <3E9C2D36.1080902@rackable.com>
Date: Tue, 15 Apr 2003 09:03:02 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nagy Tibor <nagyt@otpbank.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
References: <3E9C19A2.1040206@dell633.otpefo.com>
In-Reply-To: <3E9C19A2.1040206@dell633.otpefo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 16:05:14.0644 (UTC) FILETIME=[CCF29D40:01C30368]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagy Tibor wrote:

>
>
> There is a big hole between 00000000dffff000 and 00000000fec00000, which
> is not used on the new machine. What can I do?
>

  You might also try making sure you have the latest bios, and try 
turning off acpi in the bios.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


