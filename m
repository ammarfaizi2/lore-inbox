Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUJEXtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUJEXtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJEXtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:49:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:30927 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266034AbUJEXth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:49:37 -0400
Date: Tue, 5 Oct 2004 16:53:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2 ip_conntrack problems
Message-Id: <20041005165314.422a3281.akpm@osdl.org>
In-Reply-To: <200410051913.00266.edt@aei.ca>
References: <20041004020207.4f168876.akpm@osdl.org>
	<200410041941.56453.edt@aei.ca>
	<20041004170853.34d25529.akpm@osdl.org>
	<200410051913.00266.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> The startup hangs at the same place rc2-mm1 did.

I'll forward your report to linux-usb-devel@lists.sourceforge.net.
The USB tree seems fairly broken lately.

> Disabling APCI does not help.  Recient mm build only
> work if APCI is enabled here.

Please send a .config which exhibits this failure.

