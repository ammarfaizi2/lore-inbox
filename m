Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVDKRKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVDKRKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKRKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 13:10:50 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:28545 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261846AbVDKRJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 13:09:59 -0400
Subject: Re: kernel panic!
From: Lee Revell <rlrevell@joe-job.com>
To: sauro <sauro@ztec.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <425AA62F.2010406@ztec.com.br>
References: <425AA62F.2010406@ztec.com.br>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 13:09:58 -0400
Message-Id: <1113239398.31605.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 13:30 -0300, sauro wrote:
> I mean, is it possible for an user level application to be the cause of 
> a "kernel panic"? If it is, which kind of operations can do that?

If this happens then by definition it's a bug in the kernel (or a
hardware failure).  It's never the fault of the userspace application
that triggers the panic.

If you think you have found such a bug in the kernel, please post the
details to this list.

Lee


