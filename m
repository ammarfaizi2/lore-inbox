Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUIWSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUIWSNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIWSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:13:11 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:46270 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268216AbUIWSL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:11:57 -0400
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ak@muc.de, gandalf@wlug.westbo.se
Content-Type: text/plain
Organization: 
Message-Id: <1095962839.4974.965.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2004 14:07:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> Martin Josefsson <gandalf@wlug.westbo.se> writes:

>> Ever heard of iptables?
>
> Except that it doesn't have usable 32bit emulation
> on x86-64. 32bit userland on x86-64 kernel cannot
> use iptables, they have to use ipchains.
>
> I would ask for to not drop ipchains until this is fixed.

Who is doing a 32-bit userland on x86-64, and WTF for?
Why do they not also run a 32-bit kernel?


