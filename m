Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVCVWBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVCVWBY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVCVWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:01:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:1248 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262083AbVCVWAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:00:42 -0500
Date: Tue, 22 Mar 2005 14:00:27 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/9] [RFC] Steps to fixing the driver model locking
Message-ID: <20050322220026.GA5801@kroah.com>
References: <Pine.LNX.4.50.0503211234040.20647-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503211234040.20647-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:48:28PM -0800, Patrick Mochel wrote:
> 
> Thoughts, comments, flames?

Looks good, thanks for doing this work.  I've pulled these patches into
my drivers bk tree and they will show up in the next -mm releases.
Let's see if anyone screams then :)

thanks,

greg k-h
