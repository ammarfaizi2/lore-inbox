Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVCKR1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVCKR1a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCKR13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:27:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:9428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261218AbVCKRZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:25:27 -0500
Date: Fri, 11 Mar 2005 09:25:14 -0800
From: Greg KH <greg@kroah.com>
To: Michael Raymond <mraymond@sgi.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Message-ID: <20050311172514.GB1768@kroah.com>
References: <16945.4650.250558.707666@berry.gelato.unsw.EDU.AU> <20050311075029.A92696@goliath.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311075029.A92696@goliath.americas.sgi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:50:32AM -0600, Michael Raymond wrote:
>     I have many users asking for something like this.

Why would a "user" care about this?

Now hardware companies that want to write closed drivers is another
thing :)

thanks,

greg k-h
