Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbTIMEBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 00:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTIMEBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 00:01:46 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13576
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261905AbTIMEBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 00:01:45 -0400
Date: Fri, 12 Sep 2003 21:01:51 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Bradford <john@grabjohn.com>, anthony.truong@mascorp.com,
       linux-kernel@vger.kernel.org, jamie@shareable.org, willy@debian.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030913040151.GI30584@matchmail.com>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	anthony.truong@mascorp.com, linux-kernel@vger.kernel.org,
	jamie@shareable.org, willy@debian.org
References: <200309121641.h8CGflK0000145@81-2-122-30.bradfords.org.uk> <20030912215203.GF30584@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912215203.GF30584@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 02:52:03PM -0700, Mike Fedyk wrote:
> If there's already a config option that keeps code from being compiled when
> it's not used, then it should stay.

Nevermind, after reading the whole thread I see how that doesn't make sense
in this case.
