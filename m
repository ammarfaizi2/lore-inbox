Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVBCFAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVBCFAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVBCFAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:00:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:28840 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262289AbVBCFAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:00:37 -0500
Date: Wed, 2 Feb 2005 20:57:36 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: Joseph Pingenot <trelane@digitasaru.net>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050203045736.GA17820@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <20050203000917.GA12204@digitasaru.net> <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0502021950040.19812@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 08:13:15PM -0500, Pavel Roskin wrote:
> 
> I won't open all details, but suppose I want the bridge to handle certain 
> frames in a special way, just like BPDU frames are handled if STP is 
> enabled.  There is a hook for that already - see br_handle_frame_hook. 
> The proprietary module would just have to change it.

Why use Linux if you want to make a proprietary module?  Why not use
another operating system that is more suited toward such usage.  The
Linux kernel certainly is not such a system.

greg k-h
