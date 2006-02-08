Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWBHWjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWBHWjf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 17:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWBHWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 17:39:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:58072 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965217AbWBHWje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 17:39:34 -0500
Date: Wed, 8 Feb 2006 23:39:32 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new tty buffering locking fix
Message-ID: <20060208223932.GA29533@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org> <20060207123450.GA854@suse.de> <1139329302.3019.14.camel@amdx2.microgate.com> <20060207171111.GA15912@suse.de> <1139347644.3174.16.camel@amdx2.microgate.com> <1139361293.22595.14.camel@localhost.localdomain> <1139436317.12888.7.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1139436317.12888.7.camel@amdx2.microgate.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Feb 08, Paul Fulghum wrote:

> Olaf: can you please test this with the hvc?

Yes, works for me, tested with -git6

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
