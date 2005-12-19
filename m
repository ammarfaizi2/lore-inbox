Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVLSQ5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVLSQ5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVLSQ5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:57:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30670 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964851AbVLSQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:57:41 -0500
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
	DECT PABX
From: Lee Revell <rlrevell@joe-job.com>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Stephen Hemminger <shemminger@osdl.org>, Hansjoerg Lipp <hjlipp@web.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <43A6E209.5030406@imap.cc>
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>
	 <43A6E209.5030406@imap.cc>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 12:01:15 -0500
Message-Id: <1135011676.20747.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 17:38 +0100, Tilman Schmidt wrote:
> Unfortunately these don't fit our needs, as we are not dealing with a
> network device, but with an ISDN device.

Um, isn't that what the N in ISDN stands for?

I guess what you mean is that although ISDN devices are obviously
networking devices, the kernel uses a separate subsystem for ISDN?

Lee

