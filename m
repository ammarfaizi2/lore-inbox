Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUBHQKO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUBHQKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:10:14 -0500
Received: from main.gmane.org ([80.91.224.249]:42126 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263803AbUBHQKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:10:12 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: [PROBLEM] 2.6.3-rc1: still no suspend/resume on Centrino notebook
 (contains agp, lapic, swsusp)
Date: Sun, 08 Feb 2004 10:57:00 -0500
Message-ID: <c05m86$20g$1@sea.gmane.org>
References: <200402081522.i18FMVl7001382@brain.gnuhh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: atlantis.ccs.neu.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
In-Reply-To: <200402081522.i18FMVl7001382@brain.gnuhh.org>
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should clarify that this does not happen on *all* Centrino notebooks 
(and not the ones I've tried), only some.

> this is a a report trying to help track down the issues with suspend
> and resume on Centrino based notebooks. To make it easier to find in
> the future, I also submitted it as

