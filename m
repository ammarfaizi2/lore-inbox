Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVBPVNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVBPVNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBPVNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:13:13 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:6423 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262072AbVBPVMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:12:44 -0500
To: "govind raj" <agovinda04@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
X-Message-Flag: Warning: May contain useful information
References: <BAY10-F14B0FF7B5E49C3F0D01902D66C0@phx.gbl>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 16 Feb 2005 13:12:43 -0800
In-Reply-To: <BAY10-F14B0FF7B5E49C3F0D01902D66C0@phx.gbl> (govind raj's
 message of "Thu, 17 Feb 2005 02:38:39 +0530")
Message-ID: <52vf8sw6no.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 Feb 2005 21:12:43.0458 (UTC) FILETIME=[414DFA20:01C5146C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    govind> Thanks for your immediate response. We are just having a
    govind> single partition (hda0) in Compact Flash. We are using
    govind> /sbin/init as our init process (We have /linuxrc as a soft
    govind> link to /sbin/init).

OK, but where do you get your /sbin/init executable from?  Do you have
your inittab set up correctly (if you need one)?  Can you think of
some reason why your init process is exiting?

 - Roland
