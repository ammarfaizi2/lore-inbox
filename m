Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWARKKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWARKKz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWARKKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:10:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:20446 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751383AbWARKKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:10:54 -0500
Date: Wed, 18 Jan 2006 11:10:53 +0100
From: Olaf Hering <olh@suse.de>
To: Kumar Gala <galak@gate.crashing.org>,
       Kumar Gala <galak@kernel.crashing.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 6/6] serial8250: convert to the new platform device interface
Message-ID: <20060118101052.GA16732@suse.de>
References: <20060116233143.GB23097@flint.arm.linux.org.uk> <Pine.LNX.4.44.0601161752560.6677-100000@gate.crashing.org> <20060117193604.GA25724@suse.de> <20060118095642.GA20588@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060118095642.GA20588@flint.arm.linux.org.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 18, Russell King wrote:

> 8250 does not depend on ISA - at least not in mainline.  If it did depend
> on ISA, that would be completely wrong.

Maybe something else is busted, cant get serial output without such
change.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
