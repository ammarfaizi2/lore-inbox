Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUD1E2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUD1E2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 00:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUD1E2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 00:28:34 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:15377 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S264640AbUD1E2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 00:28:32 -0400
Date: Wed, 28 Apr 2004 06:27:42 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040428042742.GA1177@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nigel Cunningham <ncunningham@linuxmail.org>
Date: Wed, Apr 28, 2004 at 02:00:35PM +1000
> Hi all.
> 
> I'm probably going to regret this, but seeing the current discussion on  
> binary modules makes me wonder:
> 
> What does tainting actually mean?
> 
It means you can never be sure the bug is _not_ in some binary module.
It may be unprobable, you may be able to find a bug in the kernel, but
you're never _sure_.

Jurriaan
-- 
I am the pimple that forms before a really big date
	Darkwing Duck
Debian (Unstable) GNU/Linux 2.6.6-rc2-mm2 2x6062 bogomips 0.05 0.02
