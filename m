Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTFJQ33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFJQ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:29:29 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:18343 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S263418AbTFJQ33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:29:29 -0400
Subject: Re: Reiserfs vs rpm wierdness
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EE60791.8030900@rackable.com>
References: <3EE60791.8030900@rackable.com>
Content-Type: text/plain
Message-Id: <1055263387.17154.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jun 2003 09:43:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 09:30, Samuel Flory wrote:
>   Anytime I try to install an rpm, or even run "rpm -qa"  2.5.70, and RH 
> 9.   I get the following error.

It's an RPM problem.  Grab the latest rpm-4.2 RPMs from rpm.org and
install them with LD_ASSUME_KERNEL=2.2.5 set.

	<b

