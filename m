Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWJ1JwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWJ1JwY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWJ1JwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 05:52:08 -0400
Received: from ns2.suse.de ([195.135.220.15]:13973 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752039AbWJ1JwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 05:52:04 -0400
From: Andi Kleen <ak@suse.de>
To: thockin@hockin.org
Subject: Re: AMD X2 unsynced TSC fix?
Date: Sat, 28 Oct 2006 02:48:32 -0700
User-Agent: KMail/1.9.1
Cc: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Lee Revell <rlrevell@joe-job.com>, Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
References: <1161969308.27225.120.camel@mindpipe> <200610272106.13115.ak@suse.de> <20061028063524.GA7669@hockin.org>
In-Reply-To: <20061028063524.GA7669@hockin.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610280248.32405.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Does Intel guarantee that, or is that just what we happen to see, so far.

I don't think it's architecturally guaranteed no.

-Andi

