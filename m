Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVBIGJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVBIGJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 01:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVBIGJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 01:09:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:39813 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261792AbVBIGJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 01:09:14 -0500
Date: Tue, 8 Feb 2005 22:09:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1: two oops on startup
Message-Id: <20050208220903.190c02af.akpm@osdl.org>
In-Reply-To: <4209A6DA.109@tequila.co.jp>
References: <20050204103350.241a907a.akpm@osdl.org>
	<4209A6DA.109@tequila.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>
> during startup I get too oops on my Box

Yes, it is being worked on.  You'll need to CONFIG_INOTIFY=n, thanks.
