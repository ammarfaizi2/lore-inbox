Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUDUANC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUDUANC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUDUANC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:13:02 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:51908 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263775AbUDUAM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:12:59 -0400
To: Adam Litke <agl@us.ibm.com>
Cc: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: stack dumps, CONFIG_FRAME_POINTER and i386 (was Re: sysrq shows impossible call stack)
References: <408545AA.6030807@mellanox.co.il> <52ekqizkd2.fsf@topspin.com>
	<40855F95.7080003@mellanox.co.il> <5265buzgfn.fsf_-_@topspin.com>
	<1082492730.716.76.camel@agtpad>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 20 Apr 2004 17:12:57 -0700
In-Reply-To: <1082492730.716.76.camel@agtpad>
Message-ID: <52llkqw5me.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Apr 2004 00:12:58.0079 (UTC) FILETIME=[6691AEF0:01C42735]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Adam> This problem was annoying me a few months ago so I coded up
    Adam> a stack trace patch that actually uses the frame pointer.
    Adam> It is currently maintained in -mjb but I have pasted below.
    Adam> Hope this helps.

Thanks, that looks really useful.  What is the chance of this moving
from -mjb to mainline?

 - R.
