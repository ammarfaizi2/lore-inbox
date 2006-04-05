Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWDEBQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWDEBQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 21:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWDEBQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 21:16:49 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18664 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751031AbWDEBQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 21:16:48 -0400
Subject: Re: How to debug an Oops on  FC4 2.6 Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Peter Van <plst@ws.sbcoxmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <009b01c65431$939c9100$2801010a@Dolphin>
References: <009b01c65431$939c9100$2801010a@Dolphin>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 21:16:42 -0400
Message-Id: <1144199803.8122.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 11:38 -0800, Peter Van wrote:
> /var/log/messages has an  Oops log but I don't know how to use the
> Oops log to 
> determine the cause of the problem.  According to some posts,
> ksymoops can't be 
> used
> on a 2.6 kernel.

Yes, and as you can see this Oops already has the symbols resolved in
it.  So there's no need to run ksymoops at all - posting the Oops as you
did is fine.

If you don't get a resolution to your problem please open a kernel
bugzilla report.

Lee

