Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTIYXVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTIYXVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:21:24 -0400
Received: from mail.kroah.org ([65.200.24.183]:26035 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261850AbTIYXVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:21:23 -0400
Date: Thu, 25 Sep 2003 16:21:25 -0700
From: Greg KH <greg@kroah.com>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
Message-ID: <20030925232125.GA30805@kroah.com>
References: <20030925160351.E26493@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925160351.E26493@one-eyed-alien.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 04:03:51PM -0700, Matthew Dharm wrote:
> I'd like to be able to access some ioports to some custom hardware directly
> from userspace, without creating a specialized kernel-level driver.  Is
> there a way to do that?

/dev/port?
