Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268629AbUHLRmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268629AbUHLRmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268635AbUHLRmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:42:37 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:37653 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S268629AbUHLRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:42:35 -0400
Subject: Re: [Linux-cluster] Re: [cgl_discussion] Re: [dcl_discussion]
	Clustersummit materials
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: "Walker, Bruce J" <bruce.walker@hp.com>, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>,
       Discussion of clustering software components including
	 GFS <linux-cluster@redhat.com>,
       dcl_discussion@osdl.org, cgl_discussion@osdl.org
In-Reply-To: <20040812095736.GE4096@marowsky-bree.de>
References: <3689AF909D816446BA505D21F1461AE4C75110@cacexc04.americas.cpqcorp.net>
	 <1092249962.4717.21.camel@persist.az.mvista.com>
	 <20040812095736.GE4096@marowsky-bree.de>
Content-Type: text/plain; charset=UTF-8
Organization: MontaVista Software, Inc.
Message-Id: <1092332536.7315.1.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 10:42:16 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 02:57, Lars Marowsky-Bree wrote:
> On 2004-08-11T11:46:03,
>    Steven Dake <sdake@mvista.com> said:
> 
> > If we can't live with the cluster services in userland (although I'm
> > still not convinced), then atleast the group messaging protocol in the
> > kernel could be based upon 20 years of research in group messaging and
> > work properly under _all_ fault scenarios.
> 
> Right. Another important alternative maybe the Transis group
> communication suite, which has been released as GPL/LGPL now.
> 
> This all just highlights that we need to think about communication some
> more before we can tackle it sensibly, but of course I'll be glad if
> someone proves me wrong and Just Does It ;-)
> 

agreed...  Transis in kernel would be a fine alternative to openais gmi
in kernel.

Speaking of transis, is the code posted anywhere?  I'd like to have a
look.

Thanks
-steve
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

