Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbUJZBZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbUJZBZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbUJZBVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:21:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4051 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261868AbUJZBRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:17:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kill pm_access & friends from input layer
Date: Mon, 25 Oct 2004 17:50:55 -0500
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@zip.com.au>,
       vojtech@suse.cz
References: <20041025220010.GA24253@elf.ucw.cz>
In-Reply-To: <20041025220010.GA24253@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410251750.56328.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 05:00 pm, Pavel Machek wrote:
> Hi!
> 
> pm_access is a NOP (both in CONFIG_PM and !CONFIG_PM cases, its simply
> obsolete), and ugly one, too. This removes it from input layer. Please
> apply,
> 
Hi,

It is already in Vojtech's tee (Pat killed them).

-- 
Dmitry
