Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVEPTxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVEPTxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVEPTxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:53:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261844AbVEPTwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:52:42 -0400
Date: Mon, 16 May 2005 15:52:24 -0400
From: Dave Jones <davej@redhat.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
Subject: Re: Linux 2.6.11.10
Message-ID: <20050516195224.GD10390@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
	stable@kernel.org
References: <20050516182544.GA9960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516182544.GA9960@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 11:25:45AM -0700, Greg KH wrote:
 > Summary of changes from v2.6.11.9 to v2.6.11.10
 > ==============================================
 > 
 > Dave Jones:
 >   o Fix root hole in raw device

I was just the bringer of bad news this time ;-)

Stephen Tweedie spotted the real problem here, and based
his patch on one from Jan Glauber.

		Dav

