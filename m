Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTEBU54 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTEBU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:57:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263180AbTEBU5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:57:54 -0400
Message-ID: <3EB2DEA2.6070002@zytor.com>
Date: Fri, 02 May 2003 14:09:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com.suse.lists.linux.kernel> <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel> <b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73n0i5138g.fsf@oldwotan.suse.de> <3EB2DB8C.70600@zytor.com> <20030502210758.GB21239@oldwotan.suse.de>
In-Reply-To: <20030502210758.GB21239@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>
>>Why is that?  And, in particular, why is it "too late to turn it back
> 
> mprotect() didn't (and probably still does not) work when you change
> PROT_EXEC.
>

Kernel bug or CPU bug?

	-hpa

