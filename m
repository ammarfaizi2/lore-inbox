Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVAGJHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVAGJHc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVAGJHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:07:31 -0500
Received: from gw.goop.org ([64.81.55.164]:41636 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261325AbVAGJER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:04:17 -0500
Subject: Re: mysterious /proc/<pid>/maps breakage with static binaries in
	2.6.10-mm2
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1105088099.11504.12.camel@localhost>
References: <1105088099.11504.12.camel@localhost>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 01:04:16 -0800
Message-Id: <1105088656.11504.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-0.mozer.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 00:54 -0800, Jeremy Fitzhardinge wrote:
> 2.6.10-mm1 works fine (hm, better check, but it doesn't cause Valgrind
> to spectacularly explode like this does, so I assume its basically OK),
> so this is something new.

Hm, I never got around to running -mm1 (compiled it, but mm2 appeared
before I booted it).  So this is vs. plain 2.6.10.  I'll try -mm1.

	J

