Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUKJSIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUKJSIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUKJSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:08:06 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:64135 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262037AbUKJSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:07:35 -0500
Subject: Re: CELF interest in suspend-to-flash
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Tim Bird <tim.bird@am.sony.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <419256F8.3010305@am.sony.com>
References: <419256F8.3010305@am.sony.com>
Content-Type: text/plain
Message-Id: <1100109991.12290.41.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 05:06:31 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-11 at 04:59, Tim Bird wrote:
> Hi all,
> 
> Lately, the CE Linux Forum power management working group is showing some
> interest in suspend-to-flash.  Is there any current work in this area?
> 
> Who should we talk to if we want to get involved with this (or lead
> an effort if there isn't one)?

Can flash be treated as a swap device at the moment? If so, it might
simply be a matter of specifying the same parameter used in swapon for
the resume2= boot parameter.

If more work is required, I'd happily help, although I might be a little
slow: I'm only work on this on a voluntary basis at the moment (looking
for full time work, from next month though).

Regards,

Nigel

> =============================
> Tim Bird
> Architecture Group Chair, CE Linux Forum
> Senior Staff Engineer, Sony Electronics
> =============================
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

