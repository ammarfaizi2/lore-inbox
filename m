Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWBGRLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWBGRLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBGRLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:11:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:45804 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750971AbWBGRLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:11:13 -0500
Date: Tue, 7 Feb 2006 18:11:11 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new tty buffering locking fix
Message-ID: <20060207171111.GA15912@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org> <20060207123450.GA854@suse.de> <1139329302.3019.14.camel@amdx2.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1139329302.3019.14.camel@amdx2.microgate.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Feb 07, Paul Fulghum wrote:

> Try the below patches (for testing only, I'm not suggesting
> these as a final fix yet) and let me know if it fixes it.

Yes, this works for me.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
