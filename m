Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWDUVPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWDUVPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWDUVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:15:31 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:41159 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S964784AbWDUVPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:15:30 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Gross, Mark" <mark.gross@intel.com>
Subject: Re: Problems with EDAC coexisting with BIOS
Date: Fri, 21 Apr 2006 23:13:06 +0200
User-Agent: KMail/1.9.1
Cc: bluesmoke-devel@lists.sourceforge.net,
       "LKML" <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
References: <5389061B65D50446B1783B97DFDB392D998732@orsmsx411.amr.corp.intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392D998732@orsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212313.08791.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Friday, 21. April 2006 18:01, Gross, Mark wrote:
> I'm sorry to have to bring up these issues after a fare amount of good
> work, and I don't know how this problem managed to get by for as long as
> it has, but there are some issues with the EDAC and the BIOS for managed
> computer systems.

Can this condition be detected via DMI?

Then you could implement a whitelist or blacklist
and a module parameter to override it.


Regards

Ingo Oeser
