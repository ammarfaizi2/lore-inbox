Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbTHGQ1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHGQ1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:27:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:32138 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270321AbTHGQ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 12:27:23 -0400
Date: Thu, 7 Aug 2003 09:29:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: themel@iwoars.net, linux-kernel@vger.kernel.org
Subject: Re: Device-backed loop broken in 2.6.0-test2?
Message-Id: <20030807092913.6db267f1.akpm@osdl.org>
In-Reply-To: <200308071607.h77G7WPp005392@turing-police.cc.vt.edu>
References: <20030806224022.GA3741@iwoars.net>
	<20030806174043.27fd674a.akpm@osdl.org>
	<200308071607.h77G7WPp005392@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> /Valdis (who is off to apply the patch that Andrew attached, which doesn't appear to
>  be in -mm5)...

mm5 fixed it differently.

