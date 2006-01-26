Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWAZTN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWAZTN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWAZTN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:13:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15529 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964825AbWAZTN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:13:56 -0500
In-Reply-To: <20060125172607.GA14864@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: a1426z@gawab.com, barryn@pobox.com, bernd@firmix.at,
       Diego Calleja <diegocg@gmail.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-os@analogic.com, mloftis@wgops.com,
       ram.gupta5@gmail.com, vonbrand@inf.utfsm.cl
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF06994E82.1B6EC789-ON88257102.0068FBB7-88257102.0069A1A0@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 26 Jan 2006 11:13:46 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/26/2006 14:13:45,
	Serialize complete at 01/26/2006 14:13:45
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Opera is probably the best browser when it comes to "features per byte
>> of memory used"
>
>Really?  If I'm making use it, maybe visiting a few hundred pages a
>day, and opening 20 tabs, I find I have to kill it every few days, to
>reclaim the memory it's hogging, when its resident size exceeds my RAM
>size and it starts chugging.

That matches my experience, though it does crash enough on its own that I 
often don't have to kill it.  I also use an rlimit (64MiB) to make the 
system kill it automatically before it gets too big, and an automatic 
restarter.  Opera is, thankfully, very good at bouncing back to exactly 
where it was when it died (minus the leaked memory).

But allowing for that extra operational procedure, I'd still say it has 
the most features per byte, and if you don't count ability to work with 
certain websites as a feature, I think it probably has the most features 
absolutely as well.

