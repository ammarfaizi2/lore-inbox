Return-Path: <linux-kernel-owner+w=401wt.eu-S1947328AbWLHVqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947328AbWLHVqf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 16:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947390AbWLHVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 16:46:35 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:14492 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947388AbWLHVqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 16:46:33 -0500
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
X-Message-Flag: Warning: May contain useful information
References: <20061208182241.786324000@osdl.org>
	<20061208182500.611327000@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 08 Dec 2006 13:46:08 -0800
In-Reply-To: <20061208182500.611327000@osdl.org> (Stephen Hemminger's message of "Fri, 08 Dec 2006 10:22:45 -0800")
Message-ID: <adahcw66oyn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Dec 2006 21:46:11.0914 (UTC) FILETIME=[47130AA0:01C71B12]
Authentication-Results: sj-dkim-2; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine (assuming the PCI core interfaces it uses go in).

Acked-by: Roland Dreier <rolandd@cisco.com>
