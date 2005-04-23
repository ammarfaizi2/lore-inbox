Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVDWWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVDWWDO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVDWWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 18:03:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24203 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262081AbVDWWDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 18:03:10 -0400
Date: Sun, 24 Apr 2005 00:02:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [2/4]
Message-ID: <20050423220253.GB1884@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl> <200504232329.18407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504232329.18407.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 23-04-05 23:29:18, Rafael J. Wysocki wrote:
> The following patch removes the unnecessary functions does_collide_order().
> 
> This function is no longer necessary, as currently there are only 0-order
> allocations in swsusp, and the use of it is confusing.
> 
> Please consider for applying.

Applied (to git).
									Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
