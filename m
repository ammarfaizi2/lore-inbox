Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752598AbWAHFme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbWAHFme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 00:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbWAHFme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 00:42:34 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:6795 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1752598AbWAHFmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 00:42:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1lSejWQgjM08nWywm2JlXf5mcAQZx+6TNXbumuUw2ca78R3vVFV02GYOR6hftj/4PSyBmR1PienwgB/mcB6nZAM2Jk89RrlM0yL5tTpFBqOy/uM5ByQDiKSif9ErZbJl4r0Eaw7GPyGW1GN2fgcGS1iGpa+NhZDdQuQ4RXqCbJw=  ;
Message-ID: <43C0A64A.20608@yahoo.com.au>
Date: Sun, 08 Jan 2006 16:42:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/4] mm: de-skew page_count
References: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
In-Reply-To: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> The following patchset (against 2.6.15-rc5ish)

Sorry, that should read 2.6.15-git3 (latest git).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
