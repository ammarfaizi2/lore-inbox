Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWCFHGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWCFHGz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWCFHGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:06:55 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48789
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751929AbWCFHGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:06:55 -0500
Date: Sun, 05 Mar 2006 23:07:11 -0800 (PST)
Message-Id: <20060305.230711.06026976.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060306070456.GA16478@redhat.com>
References: <20060306070456.GA16478@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Mon, 6 Mar 2006 02:04:58 -0500

> (I wish we had a kfree variant that NULL'd the target when it was free'd)

Excellent idea.
