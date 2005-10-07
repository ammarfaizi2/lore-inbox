Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbVJGVBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbVJGVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbVJGVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:01:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030559AbVJGVBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:01:16 -0400
Date: Fri, 7 Oct 2005 13:57:40 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP syncronization on AMD processors (broken?)
Message-ID: <20051007135740.6188ba36@dxpl.pdx.osdl.net>
In-Reply-To: <di6m79$38f$1@sea.gmane.org>
References: <434520FF.8050100@sw.ru>
	<di6m79$38f$1@sea.gmane.org>
X-Mailer: Sylpheed-Claws 1.9.14 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots and lots of papers on this, you might also
want to consider.

	http://www.cs.vu.nl/~swami/fairlocks.pdf

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
