Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWBCSZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWBCSZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWBCSZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:25:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751328AbWBCSZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:25:56 -0500
Date: Fri, 3 Feb 2006 10:24:30 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OSS driver removal, a slightly different approach (v3)
Message-Id: <20060203102430.46ec9b49.zaitcev@redhat.com>
In-Reply-To: <mailman.1138488794.780.linux-kernel2news@redhat.com>
References: <mailman.1138488794.780.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jan 2006 23:47:58 +0100, Adrian Bunk <bunk@stusta.de> wrote:

I think it was a grand idea to slice this behemoth into thin slabs.

> SOUND_YMFPCI

Most definitely. In fact, if you run into opposition, I can remove
it myself. That driver was never even meant to carry forward to 2.6,
it's a 2.4-only solution.

> SOUND_FUSION

Same as YMFPCI, only belongs to Alan Cox.

-- Pete
