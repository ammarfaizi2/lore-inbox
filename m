Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVD2Dsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVD2Dsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbVD2Dsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:48:32 -0400
Received: from smtp.istop.com ([66.11.167.126]:37065 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262378AbVD2Dsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:48:30 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Teigland <teigland@redhat.com>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Thu, 28 Apr 2005 23:49:09 -0400
User-Agent: KMail/1.7
Cc: Lars Marowsky-Bree <lmb@suse.de>, Steven Dake <sdake@mvista.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Patrick Caulfield <pcaulfie@redhat.com>
References: <20050425165826.GB11938@redhat.com> <200504282026.36273.phillips@istop.com> <20050429025226.GA9900@redhat.com>
In-Reply-To: <20050429025226.GA9900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504282349.10164.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 22:52, David Teigland wrote:
> On Thu, Apr 28, 2005 at 08:26:35PM -0400, Daniel Phillips wrote:
> > Indeed, you caught me being imprecise.  By "membership system" I mean
> > cman, which includes basic cluster membership, service groups, socket
> > interface, event messages, PF_CLUSTER, and a few other odds and ends. 
> > Really, it _is_ our cluster infrastructure.  And it has warts, some
> > really giant ones.  At least it did the last time I used it.  There is
> > apparently a new, much-improved version I haven't seen yet.  I have heard
> > that the re-rolled cman is in cvs somewhere.  Patrick?  Dave?
>
> ...Nothing you have said is remotely correct.

Please provide corrections, if you wish Dave.

Regards,

Daniel
