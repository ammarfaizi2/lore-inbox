Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268498AbUHLKA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268498AbUHLKA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 06:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268500AbUHLKA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 06:00:58 -0400
Received: from gate.in-addr.de ([212.8.193.158]:40602 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S268498AbUHLKA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 06:00:57 -0400
Date: Thu, 12 Aug 2004 11:57:36 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Steven Dake <sdake@mvista.com>, "Walker, Bruce J" <bruce.walker@hp.com>,
       linux-kernel@vger.kernel.org
Cc: Chris Wright <chrisw@osdl.org>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       dcl_discussion@osdl.org, cgl_discussion@osdl.org
Subject: Re: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion] Clustersummit materials
Message-ID: <20040812095736.GE4096@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net> <1092249962.4717.21.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092249962.4717.21.camel@persist.az.mvista.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-11T11:46:03,
   Steven Dake <sdake@mvista.com> said:

> If we can't live with the cluster services in userland (although I'm
> still not convinced), then atleast the group messaging protocol in the
> kernel could be based upon 20 years of research in group messaging and
> work properly under _all_ fault scenarios.

Right. Another important alternative maybe the Transis group
communication suite, which has been released as GPL/LGPL now.

This all just highlights that we need to think about communication some
more before we can tackle it sensibly, but of course I'll be glad if
someone proves me wrong and Just Does It ;-)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ I allow neither my experience
SUSE Labs, Research and Development | nor my cynicism to deter my
SUSE LINUX AG - A Novell company    \ optimistic outlook on life.

