Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVKWSnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVKWSnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVKWSnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:43:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932162AbVKWSnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:43:16 -0500
Date: Wed, 23 Nov 2005 10:43:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + dont-include-schedh-from-moduleh.patch added to -mm tree
Message-Id: <20051123104302.6669df5e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0511231328020.27662@gockel.physik3.uni-rostock.de>
References: <200511050726.jA57QPs7009905@shell0.pdx.osdl.net>
	<Pine.LNX.4.63.0511231328020.27662@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
> Andrew, what are your plans for these patches?

Slam it in after 2.6.15, put fingers in ears?

>  Shall I send an updated dont-include-schedh-from-moduleh.patch whose 
>  changelog reflects the current state of testing?

You can send a new changelog if you like, but I'd prefer not to do a
wholesale replacement of a tested patch.
