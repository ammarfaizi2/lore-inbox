Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVD2CtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVD2CtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 22:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVD2CtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 22:49:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261431AbVD2CtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 22:49:07 -0400
Date: Fri, 29 Apr 2005 10:52:26 +0800
From: David Teigland <teigland@redhat.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050429025226.GA9900@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504280249.04735.phillips@istop.com> <20050428125512.GR21645@marowsky-bree.de> <200504282026.36273.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504282026.36273.phillips@istop.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 08:26:35PM -0400, Daniel Phillips wrote:

> Indeed, you caught me being imprecise.  By "membership system" I mean cman, 
> which includes basic cluster membership, service groups, socket interface, 
> event messages, PF_CLUSTER, and a few other odds and ends.  Really, it _is_ 
> our cluster infrastructure.  And it has warts, some really giant ones.  At 
> least it did the last time I used it.  There is apparently a new, 
> much-improved version I haven't seen yet.  I have heard that the re-rolled 
> cman is in cvs somewhere.  Patrick?  Dave?

Daniel, please stop commenting on all this.  Nothing you have said is
remotely correct.  Anyone who's bothered to listen to this stuff, please
erase everything you've heard or you'll be dreadfully misled.  And that's
as kind as I can put it.

Dave

