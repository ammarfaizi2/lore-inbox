Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270689AbTGUTpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 15:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270690AbTGUTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 15:45:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42253
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270689AbTGUTpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 15:45:31 -0400
Date: Mon, 21 Jul 2003 13:00:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rus Foster <rghf@fsck.me.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is this bad?
Message-ID: <20030721200031.GC14453@matchmail.com>
Mail-Followup-To: Rus Foster <rghf@fsck.me.uk>,
	linux-kernel@vger.kernel.org
References: <20030721123836.K2947@thor.65535.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721123836.K2947@thor.65535.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 12:39:14PM -0700, Rus Foster wrote:
> I'm guessing this is bad...CPU on the way out?

Ksymoops is your friend.  Please run the trace through it and post the
results.
