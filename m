Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422813AbWBIGJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWBIGJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422814AbWBIGJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:09:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:32481 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422813AbWBIGJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:09:49 -0500
Subject: Re: Linux drivers management
From: Lee Revell <rlrevell@joe-job.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: David Chow <davidchow@shaolinmicro.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207221513.GA7394@thunk.org>
References: <20060207044204.8908.qmail@science.horizon.com>
	 <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com>
	 <43E8F8EB.8010800@shaolinmicro.com>  <20060207221513.GA7394@thunk.org>
Content-Type: text/plain
Date: Thu, 09 Feb 2006 01:09:46 -0500
Message-Id: <1139465386.30058.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 17:15 -0500, Theodore Ts'o wrote:
> (In some cases, end-users send hate mail to the Linux kernel
> developers when some idiot company's binary driver modules is buggy
> and corrupts the kernel in hard-to-debug ways; one particular video
> driver company is especially guilty here, and is viewed by some as
> being directly responsible for the tainted kernel flags.) 

Wouldn't the tainted kernel flags be necessary even if there had never
been a single bug in any binary driver, simply because there's still no
reasonable way to debug a kernel with binary drivers loaded?

Lee

