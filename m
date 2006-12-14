Return-Path: <linux-kernel-owner+w=401wt.eu-S932819AbWLNPlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932819AbWLNPlT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbWLNPlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:41:19 -0500
Received: from dvhart.com ([64.146.134.43]:51441 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932819AbWLNPlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:41:18 -0500
Message-ID: <45816F98.9040602@mbligh.org>
Date: Thu, 14 Dec 2006 07:36:56 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org> <20061214130704.GB17565@redhat.com>
In-Reply-To: <20061214130704.GB17565@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Dec 13, 2006 at 09:39:11PM -0800, Martin J. Bligh wrote:
> 
>  > The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
>  > going. If we don't stand up at some point, and ban binary drivers, we
>  > will, I fear, end up with an unsustainable ecosystem for Linux when
>  > binary drivers become pervasive. I don't want to see Linux destroyed
>  > like that.
> 
> Thing is, if kernel.org kernels get patched to disallow binary modules,
> whats to stop Ubuntu (or anyone else) reverting that change in the
> kernels they distribute ?  The landscape doesn't really change much,
> given that the majority of Linux end-users are probably running
> distro kernels.

I don't think they'd dare spit in our faces quite that directly.
They think binary modules are permissible because we don't seem to have
consistently stated an intent contradicting that - some individual
developers have, but ultimately Linus hasn't.

I'm not talking about any legal issues to do with derived works,
copyrights or licenses - a clear statement of intent is probably all
it'd take to tip the balance.

M.
