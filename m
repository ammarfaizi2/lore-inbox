Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbULUE2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbULUE2P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 23:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbULUE2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 23:28:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:15569 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261431AbULUE2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 23:28:13 -0500
Subject: Re: Intercepting system calls
From: Lee Revell <rlrevell@joe-job.com>
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041221042224.48160.qmail@web60608.mail.yahoo.com>
References: <20041221042224.48160.qmail@web60608.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 23:28:12 -0500
Message-Id: <1103603292.8297.40.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 20:22 -0800, selvakumar nagendran wrote:
>     Can I modify the system call source code directly
> for this?

Yes.

>  or if I want the system calls to refer my
> module, how should I do that?

EXPORT_SYMBOL

Lee

