Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWBGO6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWBGO6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 09:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWBGO6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 09:58:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:24782 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965114AbWBGO6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 09:58:31 -0500
From: Andi Kleen <ak@suse.de>
To: john.blackwood@ccur.com
Subject: Re: CONFIG_K8_NUMA x86_64 no-memory node bug
Date: Tue, 7 Feb 2006 15:51:56 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
References: <43E13273.5020202@ccur.com>
In-Reply-To: <43E13273.5020202@ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071551.56602.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


John,

Can you please double check if the problem is still there in the latest 2.6.16-rc2-git* 
kernel? I fixed a couple of SRAT issues in there and at least one change could 
have fixed your problem too.

Thanks,
-Andi
