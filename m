Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJIBBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJIBBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbUJIBBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:01:52 -0400
Received: from mail.joq.us ([67.65.12.105]:52938 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S266366AbUJIBBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:01:50 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
References: <1096669179.27818.29.camel@krustophenia.net>
	<20041001152746.L1924@build.pdx.osdl.net>
	<877jq5vhcw.fsf@sulphur.joq.us>
	<1097193102.9372.25.camel@krustophenia.net>
	<1097269108.1442.53.camel@krustophenia.net>
	<20041008144539.K2357@build.pdx.osdl.net>
	<1097272140.1442.75.camel@krustophenia.net>
	<20041008145252.M2357@build.pdx.osdl.net>
	<1097273105.1442.78.camel@krustophenia.net>
	<20041008151911.Q2357@build.pdx.osdl.net>
	<20041008152430.R2357@build.pdx.osdl.net>
From: "Jack O'Quin" <joq@io.com>
Date: 08 Oct 2004 20:01:27 -0500
In-Reply-To: <20041008152430.R2357@build.pdx.osdl.net>
Message-ID: <87zn2wbt7c.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> use in_group_p

I looked at that, it wasn't clear to me whether to use in_group_p() or
in_egroup_p().  How do you choose?
-- 
  joq
