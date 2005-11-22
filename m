Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVKVUUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVKVUUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbVKVUUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:20:44 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:26121 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S965167AbVKVUUo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:20:44 -0500
Date: Tue, 22 Nov 2005 21:21:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Robert Love <rml@novell.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] hdaps: missing an axis.
Message-Id: <20051122212140.7a279f8e.khali@linux-fr.org>
In-Reply-To: <1132675041.29496.2.camel@betsy.boston.ximian.com>
References: <1132675041.29496.2.camel@betsy.boston.ximian.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

> Greg,
> 
> Trivial patch to report both hdaps axises to the joystick device, not
> just the X axis.

That would rather be for me. I've enqueued it, thanks.

Looks like a bugfix we want in 2.6.15, right?

-- 
Jean Delvare
