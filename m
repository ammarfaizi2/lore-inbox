Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTEGBth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 21:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTEGBth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 21:49:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:11966 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261994AbTEGBtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:49:36 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       devenyga@mcmaster.ca, rml@tech9.net, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: PATCH: Replace current->state with set_current_state in 2.5.6 8 
In-reply-to: Your message of Tue, 06 May 2003 18:24:56 PDT.
             <20030506182456.644b70d1.rddunlap@osdl.org> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7853.1052272887.1@us.ibm.com>
Date: Tue, 06 May 2003 19:01:27 -0700
Message-Id: <E19DEFM-00022j-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 May 2003 18:24:56 PDT, "Randy.Dunlap" wrote:
> 
> On Tue, 6 May 2003 17:33:26 -0700  "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
> 
> | However, I'd suggest to post this into the Kernel Janitors mailing list and
> | let one of the big guys there swipe it in.
> | 
> 
> Yes, the KJ list has already seen this patch and commented on some version
> of it.
 
> Then it needs some exposure, like living in -ac or -mm or -pick1,
> or at least some testing (everyday usage) by a few people, with reports
> from them.
> 
> And I don't really want to review a 176 KB patch (although I did already
> look over most of it a few days ago).  Do people want to take portions
> of it for review and then see about Alan merging it, e.g.?

Hmm.  Has anyone considered a "Kernel Janitor's" tree?  More specifically,
a patch set, much like -ac or -mm, with the current cleanups so they
can be tested, pulled, run through automated batch testing, etc.?

gerrit
