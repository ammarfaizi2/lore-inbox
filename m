Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281307AbRKEUKu>; Mon, 5 Nov 2001 15:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281311AbRKEUKf>; Mon, 5 Nov 2001 15:10:35 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:15366 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281307AbRKEUKX>;
	Mon, 5 Nov 2001 15:10:23 -0500
Date: Mon, 5 Nov 2001 13:10:14 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011105131014.A4735@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E160obZ-0001bO-00@janus>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 08 Oct 2001 20:04:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 10:36:16AM +0000, Stephan Gutschke wrote:
> Hi there,
> if anything else is needed, let me know.

Could you load the driver with "debug=1" and then try this again?  If
the oops happens, can you send me the kernel debug log?

And does this happen at the end of the sync, or the beginning?
Every time?  Occasionally?

thanks,

greg k-h
