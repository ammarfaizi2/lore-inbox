Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTEBUo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbTEBUo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:44:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26638 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263163AbTEBUo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:44:58 -0400
Message-ID: <3EB2DB8C.70600@zytor.com>
Date: Fri, 02 May 2003 13:56:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>	<200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel>	<b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73n0i5138g.fsf@oldwotan.suse.de>
In-Reply-To: <p73n0i5138g.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>
>>x86-64 definitely does, and it's the default on Linux/x86-64.
> 
> No we had to turn it off and now it's too late to turn it back on again.
> There is also one bug left that prevents it.
> 

Why is that?  And, in particular, why is it "too late to turn it back
on"?  It seems as long as it's clearly defined as the ABI that change
can be made later, effectively as a bug fix.

	-hpa


