Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbTILWK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTILWK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:10:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:33941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261303AbTILWK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:10:56 -0400
Date: Fri, 12 Sep 2003 15:08:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test[45]: enable swsusp?
In-Reply-To: <20030911215113.GB28883@butterfly.hjsoft.com>
Message-ID: <Pine.LNX.4.33.0309121507070.984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 11 Sep 2003, John M Flinchbaugh wrote:

> what needs to be configured to get the /proc/power/state file i've
> seen mentioned around here?  i'd like to try swsusp again.  the swsusp
> docs seem a bit dated.

There is documentation in Documentation/power/*.txt.

However, in order to get suspend-to-disk working, you'll need a recent -mm 
patch (e.g. 2.6.0-test5-mm1). 



	Pat

