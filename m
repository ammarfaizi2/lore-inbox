Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTIDMuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264956AbTIDMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 08:50:22 -0400
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:3257 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S264953AbTIDMuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 08:50:18 -0400
Date: Thu, 4 Sep 2003 22:50:32 +1000 (EST)
From: Michael Still <mikal@stillhq.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: carbonated beverage <ramune@net-ronin.org>, <linux-kernel@vger.kernel.org>
Subject: Re: minor TMPDIR fix
In-Reply-To: <20030903200736.GA12723@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0309042248330.12720-100000@diskbox.stillhq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Sam Ravnborg wrote:

Sam, Mr Beverage (or can I just call you Carbonated?)

> On Wed, Sep 03, 2003 at 12:27:26PM -0700, carbonated beverage wrote:
> > Hi,
> > 
> > 	Just a small fix to make the makeman script use $TMPDIR from the
> > environment if it's set.

> Michael Still contributed this script - I have added him in to:

Thanks for the patch... I'm playing with that script at the moment, so the 
timing was really good from my perspective. I'll be sending an update to 
LKML in the next few days, and I'll include this.

Thanks,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 10                          |    -- Homer Simpson

