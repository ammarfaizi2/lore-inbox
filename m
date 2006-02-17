Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWBQSmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWBQSmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWBQSmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:42:19 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:31759 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750826AbWBQSmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:42:18 -0500
Date: Fri, 17 Feb 2006 19:42:46 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: "Nick Warne" <nick@linicks.net>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: Add LM82 support
Message-Id: <20060217194246.1955d576.khali@linux-fr.org>
In-Reply-To: <20060217162922.GP20157@cosmic.amd.com>
References: <20060216175930.GE20157@cosmic.amd.com>
	<LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
	<20060217162922.GP20157@cosmic.amd.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

> On 17/02/06 13:09 +0000, Nick Warne wrote:
> > > +       else if (kind = lm82) {
> > > +               name = "lm82";
> > > +       }
> > 
> > Is that a '=' typo in the 'else if' there?
> 
> Yep - thats what that would be.  That must be my typo of the week, since
> I just had it in another driver I'm writing.

Given that gcc clearly warns on this kind of typo, how could it go
unnoticed?

-- 
Jean Delvare
