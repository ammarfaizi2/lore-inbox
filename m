Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJHVRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJHVRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUJHVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:17:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:7318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265207AbUJHVR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:17:29 -0400
Date: Fri, 8 Oct 2004 14:21:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: chrisw@osdl.org, realtime-lsm@modernduck.com, linux-kernel@vger.kernel.org,
       torbenh@gmx.de, joq@io.com
Subject: Re: [PATCH] Realtime LSM
Message-Id: <20041008142121.328b8d3a.akpm@osdl.org>
In-Reply-To: <1097269108.1442.53.camel@krustophenia.net>
References: <1094967978.1306.401.camel@krustophenia.net>
	<20040920202349.GI4273@conscoop.ottawa.on.ca>
	<20040930211408.GE4273@conscoop.ottawa.on.ca>
	<1096581213.24868.19.camel@krustophenia.net>
	<87pt43clzh.fsf@sulphur.joq.us>
	<20040930182053.B1973@build.pdx.osdl.net>
	<87k6ubcccl.fsf@sulphur.joq.us>
	<1096663225.27818.12.camel@krustophenia.net>
	<20041001142259.I1924@build.pdx.osdl.net>
	<1096669179.27818.29.camel@krustophenia.net>
	<20041001152746.L1924@build.pdx.osdl.net>
	<877jq5vhcw.fsf@sulphur.joq.us>
	<1097193102.9372.25.camel@krustophenia.net>
	<1097269108.1442.53.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Here's an updated patch, only
> difference is line numbers.

Nice patch.  Wanna tell me something about what it's for?

I haven't been following the "Realtime LSM" thread and I'd rather not have to
prepare a description of your work for you.
