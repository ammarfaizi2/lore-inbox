Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUAMIdH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 03:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAMIdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 03:33:06 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:15750 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262564AbUAMIdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 03:33:04 -0500
Date: Tue, 13 Jan 2004 03:33:03 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@portland.hansa.lan
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kpfleming@cox.net
Subject: Re: [PATCH]: Fw: [Bugme-new] [Bug 1242] New: devfs oops with SMP
 kernel (not in UP mode)
In-Reply-To: <200401041932.40960.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.58.0401130323510.1229@portland.hansa.lan>
References: <20030915212755.5017acc7.akpm@osdl.org> <200401041932.40960.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004, Andrey Borzenkov wrote:

> Pavel, you have been lucky in cathing devfs bugs, could you please test this
> if it works for you?

Yes, it does.  No apparent problems.  However, I only had lookups on Red
Hat 8 and 9, and I'm running Debian unstable now.  The kernel is
2.6.1-bk1.  devfs is enabled, devfsd is running.  SMP is not enabled.

-- 
Regards,
Pavel Roskin
