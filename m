Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUA0Aok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 19:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265621AbUA0Aok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 19:44:40 -0500
Received: from mail.kroah.org ([65.200.24.183]:59880 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265611AbUA0Aoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 19:44:38 -0500
Date: Mon, 26 Jan 2004 16:42:55 -0800
From: Greg KH <greg@kroah.com>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspicious pointer usage in kobil_sct driver.
Message-ID: <20040127004255.GC8043@kroah.com>
References: <E1Ajuub-0000xh-00@hardwired>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Ajuub-0000xh-00@hardwired>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 06:35:25AM +0000, davej@redhat.com wrote:
> Greg, is this what's intended here?

Applied, thanks.

greg k-h
