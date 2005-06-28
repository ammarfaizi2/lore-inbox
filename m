Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVF1I1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVF1I1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVF1IPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:15:25 -0400
Received: from mail.kroah.org ([69.55.234.183]:51652 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261860AbVF1IJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:09:55 -0400
Date: Tue, 28 Jun 2005 00:41:45 -0700
From: Greg KH <greg@kroah.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628074145.GC3577@kroah.com>
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 08:57:55PM -0400, Kyle Moffett wrote:
> One of the things that most annoys me about udev is that I still need
> a minimal static dev in order for the system to boot.

Why?  You should not.  Works just fine for me here :)

I suggest you work on your init scripts some more...

greg k-h
