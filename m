Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbUAHNzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUAHNzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:55:16 -0500
Received: from main.gmane.org ([80.91.224.249]:58010 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264480AbUAHNzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:55:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: RAID 5 from 2.4.24 to 2.6.0
Date: Thu, 08 Jan 2004 14:55:06 +0100
Message-ID: <yw1xwu82h7et.fsf@kth.se>
References: <20040108134303.GA3288@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:khGJqO8CE3TVWmVSlcX2+f3vPIc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin F Krafft <krafft@ailab.ch> writes:

> Due to stability problems with the RAID code in 2.4 (detaailed
> message forthcoming), I would like to try 2.6.0 on one of our
> servers. However, anticipating problems, I want to make sure that
> this change is not irreversible.

You'd better use 2.6.1-rc1 or later if you want to actually use the
arrays.

> Can I mount RAID 1 and 5 partitions in 2.6.0 and 2.4.24
> interchangeably?

Yes.

-- 
Måns Rullgård
mru@kth.se

