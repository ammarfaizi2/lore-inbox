Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752264AbWAEWpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbWAEWpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbWAEWpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:45:43 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19390 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752264AbWAEWpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:45:42 -0500
Date: Thu, 5 Jan 2006 23:45:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Preece Scott-PREECE <scott.preece@motorola.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, akpm@osdl.org,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060105224531.GK2095@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADE4D9DBCFC3A345AAA95C195F62B6DDD3AD5D@de01exm64.ds.mot.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 05-01-06 17:21:38, Preece Scott-PREECE wrote:
> We do have multiple system-level low-power modes. I believe today they
> differ in turning whole devices on or off, but there are some of those
> devices that could be put in reduced-function/lowered-speed modes if we
> were ready to use a finer-grained distinction.

I think we were talking multiple off modes for _single device_. It is
good to know that even cellphones can get away with whole devices
on/off today.
								Pavel

-- 
Thanks, Sharp!
