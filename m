Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTILUL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbTILUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:11:59 -0400
Received: from holomorphy.com ([66.224.33.161]:9662 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261828AbTILUL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:11:27 -0400
Date: Fri, 12 Sep 2003 13:12:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Brian P. Flaherty" <bxf4@psu.edu>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org, pavel@ucw.cz
Subject: Re: IBM X31 laptop, apm, test[245]
Message-ID: <20030912201234.GG6554@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Brian P. Flaherty" <bxf4@psu.edu>, linux-kernel@vger.kernel.org,
	mochel@osdl.org, pavel@ucw.cz
References: <87isnx51jj.fsf@havers.hhdev.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isnx51jj.fsf@havers.hhdev.psu.edu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 02:01:20PM -0400, Brian P. Flaherty wrote:
> I diff'ed the apm.c file in my Debian test2 source and in test5 (test2 is the
> first file):

Thanks for doing that, it made it quicker to check.

Unfortunately, I don't see anything obviously wrong with the parts I
touched. My guess is one of the power management people might have a
better idea of what's going on here in general.


-- wli
