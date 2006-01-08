Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161117AbWAHWd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbWAHWd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWAHWd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:33:56 -0500
Received: from linux.us.dell.com ([143.166.224.162]:54351 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S1161117AbWAHWdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:33:55 -0500
Date: Sun, 8 Jan 2006 16:33:46 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: Carlos Manuel Duclos Vergara <carlos@embedded.cl>,
       kernel-janitors@lists.osdl.org, Kees Cook <kees@outflux.net>,
       linux-kernel@vger.kernel.org
Subject: Re: MODULE_VERSION useless? (was Re: [KJ] adding missing MODULE_* stuffs)
Message-ID: <20060108223346.GB14784@lists.us.dell.com>
References: <20051230000400.GS18040@outflux.net> <20060108204549.GB5864@mipter.zuzino.mipt.ru> <200601081855.17723.carlos@embedded.cl> <20060108215800.GA31398@kroah.com> <20060108223200.GA14784@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108223200.GA14784@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 01:58:00PM -0800, Greg KH wrote:
> On Sun, Jan 08, 2006 at 06:55:16PM -0300, Carlos Manuel Duclos Vergara wrote:
> > 
> > I have two ideas about what to do with MODULE_VERSION:
> > 1.- Defining MODULE_VERSION = KERNEL_VERSION

vermagic already has KERNEL_VERSION, if that's what someone really
cares about.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
