Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTETSp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbTETSp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 14:45:57 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:19075
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263867AbTETSp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 14:45:57 -0400
Date: Tue, 20 May 2003 14:49:07 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: RE: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Nguyen, Tom L wrote:

> Here is a patch containing the vector-based indexing part only.

Thanks for seperating this, i'm giving it a go on 2.5.69-mm7 (requires 
some work to fit in with the removal of __DO_ACTION), i've lost my SCSI 
HBA but i should be able to fix it, i'll report back as soon as i get it 
working.

Cheers,
	Zwane
-- 
function.linuxpower.ca
