Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUD2Wc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUD2Wc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265010AbUD2Wc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:32:28 -0400
Received: from vena.lwn.net ([206.168.112.25]:14278 "HELO lwn.net")
	by vger.kernel.org with SMTP id S265007AbUD2Wc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:32:27 -0400
Message-ID: <20040429223227.16037.qmail@lwn.net>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc[23] boot failure on x86_64 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Thu, 29 Apr 2004 13:45:14 EDT."
             <1083260713.30344.291.camel@watt.suse.com> 
Date: Thu, 29 Apr 2004 16:32:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try reversing this one:
> Name: Fix cpumask iterator over empty cpu set

I'll give it a try, but I'm not particularly optimistic.  That patch went
into -rc3, but -rc2 fails for me in the same way.

Thanks,

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net

