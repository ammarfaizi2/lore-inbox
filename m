Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbTCSWDI>; Wed, 19 Mar 2003 17:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262628AbTCSWDI>; Wed, 19 Mar 2003 17:03:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33802 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262627AbTCSWDH>;
	Wed, 19 Mar 2003 17:03:07 -0500
Date: Wed, 19 Mar 2003 14:01:51 -0800
From: Greg KH <greg@kroah.com>
To: Andries.Brouwer@cwi.nl, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev_t [1/3]
Message-ID: <20030319220151.GA16947@kroah.com>
References: <UTC200303182145.h2ILjEB29313.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303182145.h2ILjEB29313.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 10:45:14PM +0100, Andries.Brouwer@cwi.nl wrote:
> Now that 2.5.65 is out, the next dev_t patch.
> It was a bit large and unreadable, so I split it into
> three clean pieces. Afterwards, since many people ask
> for this, a fourth patch that actually changes the
> type of dev_t (not to be applied yet, that is just for
> playing).

I've been beating on these three patches and don't seem to have any
problems.  And I see Andrew has put them in his -mm tree too.

Andrew, I don't see any problem with sending them on to Linus if you
want to (just the 3, not the 4th one :)

thanks,

greg k-h
