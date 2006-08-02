Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWHBWvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWHBWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWHBWvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:51:16 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14535
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932307AbWHBWvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:51:15 -0400
Date: Wed, 02 Aug 2006 15:51:10 -0700 (PDT)
Message-Id: <20060802.155110.82361263.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: tty_io wtf.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060802223604.GI3639@redhat.com>
References: <20060802223604.GI3639@redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 2 Aug 2006 18:36:04 -0400

> Looping I can understand, but forever ?

It's a do { } while() loop David.

Yes, that comment is surely poorly placed.
