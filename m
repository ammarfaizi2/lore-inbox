Return-Path: <linux-kernel-owner+w=401wt.eu-S1161057AbXAELEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbXAELEN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbXAELEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:04:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26593 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161057AbXAELEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:04:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=thJTroa6HxevmehZZqgIOLzpdTYq6Cqa6eFowDtCx4B5Cmy7XmFuxubKBtIxhXa4gFlnw+38QURvUkwjpz8DeGbIwupQVr+pyC6+9gf++czP09KnIBMpcwcgdaZvpJyVNdBzMjs0lp1fRUmtW7NryLGaqYaVPqtJE88q+1oX9Y4=
Date: Fri, 5 Jan 2007 13:03:58 +0200
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105110358.GA1903@Ahmed>
Mail-Followup-To: Alan <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de> <20070105100610.GA382@Ahmed> <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain> <20070105105113.120d72c9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105105113.120d72c9@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 10:51:13AM +0000, Alan wrote:

> Ahmed - if you can send me a patch for the tty_io/tty_ioctl code which
> switches to kzalloc where it makes sense and removes un-needed casts I'll
> review it and push the bits that look sane upstream. 
> 
> Alan

OK I'll try this now.
Are you Mr. Alan Cox. ?. Sorry, "Alan" alone is ambiguous.

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
