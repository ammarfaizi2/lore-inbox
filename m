Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVH2Uf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVH2Uf6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVH2Uf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:35:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30357 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751275AbVH2Uf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:35:57 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: John Rose <johnrose@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       lkml <linux-kernel@vger.kernel.org>,
       External List <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1125347185.19449.54.camel@sinatra.austin.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	 <20050825161325.GG25174@austin.ibm.com>
	 <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
	 <1125347185.19449.54.camel@sinatra.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1125347468.19449.56.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Aug 2005 15:31:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure that I agree with this.  Not all PCI hotplug slots have EADS
> devices as parents. 

Ahem, "PCI hotplug" above should read "EEH-enabled".

Sorry :)

John

