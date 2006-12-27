Return-Path: <linux-kernel-owner+w=401wt.eu-S932235AbWL0Upa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWL0Upa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 15:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbWL0Up3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 15:45:29 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:4730 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754727AbWL0Up3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 15:45:29 -0500
Message-ID: <4592DB73.3080603@cfl.rr.com>
Date: Wed, 27 Dec 2006 15:45:39 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: balagi@justmail.de
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "akpm@osdl.org" <akpm@osdl.org>,
       "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH 1/1] 2.6.20-rc1-mm1 pktcdvd: cleanup
References: <op.tk78gghciudtyh@master>
In-Reply-To: <op.tk78gghciudtyh@master>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2006 20:46:04.0825 (UTC) FILETIME=[06EE3090:01C729F8]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14900.000
X-TM-AS-Result: No--11.687000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please attach patches as inline text, not as a binary file, so that we 
can all read it.

Thomas Maier wrote:
> Hello,
> 
> this is a patch to cleanup some things in the pktcdvd driver for linux 2.6.20:
> 
> - update documentation
> - use clear_bdi_congested/set_bdi_congested functions directly instead of old wrappers
> - removed DECLARE_BUF_AS_STRING macro
> 
> Signed-off-by: Thomas Maier <balagi@justmail.de>

