Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbTEEQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTEEQbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:31:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11648 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263674AbTEEQap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:30:45 -0400
Date: Mon, 5 May 2003 09:45:05 -0700
From: Greg KH <greg@kroah.com>
To: Andrei Ivanov <andrei.ivanov@ines.ro>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm1
Message-ID: <20030505164505.GA1177@kroah.com>
References: <20030504231650.75881288.akpm@digeo.com> <Pine.LNX.4.50L0.0305051826500.4098-100000@webdev.ines.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L0.0305051826500.4098-100000@webdev.ines.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:32:36PM +0300, Andrei Ivanov wrote:
> 
> The usb mouse still doesn't work... :(
> Is there anything else I should try ?

Yes, does 2.5.69 (no -mm) work ok?
And what are the usb messages from the kernel log when you plug your USB
mouse in?

thanks,

greg k-h
