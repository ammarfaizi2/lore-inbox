Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWIZNjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWIZNjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWIZNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:39:04 -0400
Received: from ozlabs.org ([203.10.76.45]:16599 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751439AbWIZNjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:39:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17689.11547.179460.127518@cargo.ozlabs.ibm.com>
Date: Tue, 26 Sep 2006 23:37:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: mostrows@earthlink.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ppp-bugs@dp.samba.org
Subject: Re: Subject: [PATCH] Advertise PPPoE MTU (resubmit).
In-Reply-To: <11592702983561-git-send-email-mostrows@earthlink.net>
References: <11592702983561-git-send-email-mostrows@earthlink.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mostrows@earthlink.net writes:

> PPPoE must advertise the underlying device's MTU via the ppp channel
> descriptor structure, as multilink functionality depends on it.
> 
> Signed-off-by: Michal Ostrowski <mostrows@earthlink.net>

Acked-by: Paul Mackerras <paulus@samba.org>
