Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKEE05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 23:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTKEE05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 23:26:57 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12817
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262746AbTKEE04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 23:26:56 -0500
Date: Tue, 4 Nov 2003 20:26:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Andrew S. Johnson" <andy@asjohnson.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recurring random freezes with 2.6.0-test9
Message-ID: <20031105042650.GC32687@matchmail.com>
Mail-Followup-To: "Andrew S. Johnson" <andy@asjohnson.com>,
	linux-kernel@vger.kernel.org
References: <200311042029.38749.andy@asjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311042029.38749.andy@asjohnson.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 04, 2003 at 08:29:38PM -0600, Andrew S. Johnson wrote:
> I have 2.4.22 running fine on this box, before and after
> trying 2.6.0-test9.  What happens is that I can use the
> box for a few minutes, then it locks up hard for no apparent
> reason.  The hard drive light comes on and stays on,
> sysrq is unresponsive, and no response via ethernet.
> This has happened everytime I've used -test9 (about
> 4-6 times).  The kernel is compiled for K7 (Athlon).

I get something similar, but it takes a few days.

This is with 2.6.0-test6-mm4 #2 SMP Mon Oct 6 02:32:09 PDT 2003

I've been meaning to update for a while now... :-/
