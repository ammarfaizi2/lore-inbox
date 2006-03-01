Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbWCAAQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbWCAAQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCAAQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:16:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932728AbWCAAQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:16:27 -0500
Date: Tue, 28 Feb 2006 16:15:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Message-Id: <20060228161512.0cdbe560.akpm@osdl.org>
In-Reply-To: <200602281905_MC3-1-B97E-7FDC@compuserve.com>
References: <200602281905_MC3-1-B97E-7FDC@compuserve.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:
>
>  This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).

Wonderful, thanks.  What's the relationship (if any) between this and the
recently-merged x86_64 fix?
