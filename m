Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTENSyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTENSyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:54:45 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:55680
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263590AbTENSyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:54:44 -0400
Date: Wed, 14 May 2003 14:58:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50241361D9@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.50.0305141456090.15555-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E50241361D9@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible for you to split up the vector based indexing and the MSI 
support? There are other uses for such an indexing scheme as opposed to 
irq based.

	Zwane
-- 
function.linuxpower.ca
