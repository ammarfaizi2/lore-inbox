Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTKYAWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTKYAWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:22:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37135
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261775AbTKYAWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:22:19 -0500
Date: Mon, 24 Nov 2003 16:22:15 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031125002215.GC1586@mis-mike-wstn.matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <bpu5fk$vsn$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bpu5fk$vsn$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 11:50:12PM +0000, Bill Davidsen wrote:
> While I think you're overblowing the problem, it is an issue which might
> be addressed in SE Linux or somewhere. I have an idea on that, but I
> want to look before I suggest anything.

Other posts in this thread confirm that se-linux is able to do this if
configured correctly, and is an option in grsec.
