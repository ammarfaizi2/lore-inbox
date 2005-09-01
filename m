Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbVIAVHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbVIAVHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVIAVHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:07:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22240 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030354AbVIAVHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:07:08 -0400
Date: Thu, 1 Sep 2005 17:06:47 -0400
From: Alan Cox <alan@redhat.com>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1 - drivers/isdn/i4l/isdn_tty broken
Message-ID: <20050901210647.GB25405@devserv.devel.redhat.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <200509011941.07104.damir.perisa@solnet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509011941.07104.damir.perisa@solnet.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 07:41:02PM +0200, Damir Perisa wrote:
> hi Andrew,
> hi Alan,
> 
> updating the kernel26mm package for archlinux to 2.6.13-mm1 i found the isdn-tty to be broken:

isdn-tty needs updating and is complex to update. I've been talking with
Karsten Keil about it by email and he will take a look soon (once I send him
the diff ...)

