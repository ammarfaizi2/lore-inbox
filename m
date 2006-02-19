Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWBSDUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWBSDUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 22:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWBSDUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 22:20:33 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:60314
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750796AbWBSDUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 22:20:33 -0500
Date: Sat, 18 Feb 2006 19:20:18 -0800
From: Greg KH <greg@kroah.com>
To: Anton Blanchard <anton@samba.org>
Cc: s.schmidt@avm.de, linux-kernel@vger.kernel.org,
       opensuse-factory@opensuse.org, kkeil@suse.de
Subject: Re: 2.6.16 serious consequences / GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
Message-ID: <20060219032018.GA6913@kroah.com>
References: <200601200904.00389.dazzle.digital@gmail.com> <OF7A130C3D.76EBAB24-ONC125710A.003AC847-C125710A.005A1B7D@avm.de> <20060205205313.GA9188@kroah.com> <20060219030904.GA13520@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219030904.GA13520@krispykreme>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 02:09:04PM +1100, Anton Blanchard wrote:
> 
> FYI The lkml FAQ paints a different picture:
> 
>   Note that Linus has stated that existing symbols will not be switched to
>   GPL-only. Developers of proprietary modules for Linux need not fear.
>   Furthermore, it is quite unlikely that Linus will look favourably upon
>   the introduction of new core driver APIs which are restricted to
>   GPL-only modules. This would not be in the best interests of Linux.
>   Linus has forwarded me a message he sent to someone else to clarify his
>   views.

I suggest that this entry be updated with all of the new information
that has happened in the 8 years or so since that was written :)

thanks,

greg k-h
