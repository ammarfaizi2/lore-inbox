Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTD3Vkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTD3Vkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:40:55 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47699 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262434AbTD3Vkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:40:55 -0400
Date: Wed, 30 Apr 2003 17:53:13 -0400
From: Jeff Garzik <jgarzik@redhat.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: greg@kroah.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030430175313.A19093@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0304301640450.8917-100000@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304301640450.8917-100000@humbolt.us.dell.com>; from Matt_Domsch@Dell.com on Wed, Apr 30, 2003 at 04:45:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, gee.  It's so pretty it's hard to say no.  :)

I've wanted this capability, dynamically adding PCI ids to drivers, for
a while.  In addition to this feature, it also makes the existing code
a bit better.  And it certainly seems sysfs-friendly, though getting
an expert in that area to look over the sysfs parts would be nice, too.

	Jeff



