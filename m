Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWHDU0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWHDU0O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 16:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWHDU0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 16:26:14 -0400
Received: from natreg.rzone.de ([81.169.145.183]:47243 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S932622AbWHDU0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 16:26:14 -0400
Date: Fri, 4 Aug 2006 22:26:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Futex BUG in 2.6.18rc2-git7
Message-ID: <20060804202602.GA24459@aepfle.de>
References: <200608040917.00690.ak@suse.de> <20060804082637.GA19493@aepfle.de> <200608041036.47763.ak@suse.de> <1154722335.5932.243.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1154722335.5932.243.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:12:15PM +0200, Thomas Gleixner wrote:

> Is the glibc the latest CVS version ?

Its a snapshot from 2006073023.
