Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267607AbUIOV5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUIOV5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUIOV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:56:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:7357 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267607AbUIOVyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:54:46 -0400
Date: Wed, 15 Sep 2004 14:54:12 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@novell.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915215412.GA26308@kroah.com>
References: <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <1095284330.3508.11.camel@localhost.localdomain> <1095284369.23385.125.camel@betsy.boston.ximian.com> <20040915214919.GC22361@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915214919.GC22361@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:49:19PM -0700, Tim Hockin wrote:
> 
> What worries me more is that only some mount/umount calls get events, and
> not all of them.

That should be fixed, and I think Robert has already said they will fix
that.

thanks,

greg k-h


-- 
