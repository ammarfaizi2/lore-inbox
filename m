Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVI2QYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVI2QYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVI2QX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:23:59 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:49926 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932233AbVI2QX7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:23:59 -0400
Message-ID: <433C151B.7090603@vmware.com>
Date: Thu, 29 Sep 2005 09:23:55 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 0/3] GDT alignment fixes
References: <200509282140.j8SLelHR032216@zach-dev.vmware.com> <Pine.LNX.4.58.0509290851370.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509290851370.3308@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 16:23:57.0143 (UTC) FILETIME=[30F5DE70:01C5C512]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Just fyi, 
> I'll leave this until after 2.6.14, since it doesn't seem to be that 
>pressing. Can you re-send after the release (preferably with the relevant 
>people having signed-off on it or at least added their "acked-by" lines?)
>  
>

No problems - all of this should be brewing in -mm if not there already 
and will be ready to go in the first week of 2.6.15 developement.  
Judging by the quickening pace, I'm guessing that will be soon?

Zach
