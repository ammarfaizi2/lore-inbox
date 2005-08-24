Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVHXUdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVHXUdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHXUdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:33:37 -0400
Received: from animx.eu.org ([216.98.75.249]:16287 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S932124AbVHXUdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:33:37 -0400
Date: Wed, 24 Aug 2005 16:52:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: robotti@godmail.com, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050824205237.GB14136@animx.eu.org>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>, robotti@godmail.com,
	linux-kernel@vger.kernel.org,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <200508232205.j7NM5l1g018046@ms-smtp-01.rdc-nyc.rr.com> <20050824025740.GA3361@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824025740.GA3361@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> I have a path for initramfs to use tmpfs.  It's sorta hacky so I never
> submitted it and solves a niche problem for embedded people.
> 
> Ultimately we might one day still want to change how we initialize the
> early userspace (Al suggesting a reasomably nice way to move the
> decompressor(s) to userspace for example) so I don't feel there is a
> compelling reason to do more than cleanups in this area right now.

Care to send me the patch?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
