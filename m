Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWCNDx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWCNDx3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWCNDx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:53:29 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:50084 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932564AbWCNDx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:53:29 -0500
From: Grant Coady <gcoady@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: j4K3xBl4sT3r <jakexblaster@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Which kernel is the best for a small linux system?
Date: Tue, 14 Mar 2006 14:53:19 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <n0fc12h6jbh23bu94aold74gvi6l8e7fpo@4ax.com>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <20060313182725.GA31211@mars.ravnborg.org> <200603140000.45052.pantelis@embeddedalley.com> <436c596f0603131401l479dd4b5q164017f701b37289@mail.gmail.com> <1142288745.13256.57.camel@mindpipe>
In-Reply-To: <1142288745.13256.57.camel@mindpipe>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006 17:25:44 -0500, Lee Revell <rlrevell@joe-job.com> wrote:

>On Mon, 2006-03-13 at 19:01 -0300, j4K3xBl4sT3r wrote:
>> so, in the case of the big footprints, might I use a 2.4.x instead of
>> 2.6.x just to avoid memory leaks and performance loss? 
>
>Simply using more memory than a previous version is not a memory leak.

Sure, but there are measured performance loss in some areas 2.6 vs 2.4, 
which seem unimportant to others on lkml.  Interactive ssh console delay 
is the one I notice and have reported a couple times to lkml without 
resolution.  

While 2.4.latest is getting security fixes from Willy Tarreau, I trust 
it more than 2.6.stable to run the firewall box here, which is an old 
pentium/mmx 233 box.  

Grant.
