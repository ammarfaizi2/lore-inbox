Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUJQEN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUJQEN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 00:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUJQEN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 00:13:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2008 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269048AbUJQEN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 00:13:27 -0400
Subject: Re: Running user processes in kernel mode; Java and .NET support
	in kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Simon Kissane <skissane@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <82fa66380410152111143f75ec@mail.gmail.com>
References: <82fa66380410152111143f75ec@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1097985637.2148.49.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 00:00:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 00:11, Simon Kissane wrote:
> Hi,
> 
> I have some ideas, which I think:
> -	Wouldn't be too hard to implement,
> -	And would give Linux a distinctive advantage over competing
> platforms such as Solaris or Windows, when executing Java or .NET code

Last time I checked Java code still ran a lot slower than the native
equivalent.  If you are trying to speed up your Java apps then improving
the JVM would be a much better use of your time.

The kernel is just another program, the same code will run just as fast
in kernel mode as in user mode.

Lee

