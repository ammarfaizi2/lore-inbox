Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266734AbRGKQSI>; Wed, 11 Jul 2001 12:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266738AbRGKQR6>; Wed, 11 Jul 2001 12:17:58 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:35589 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266734AbRGKQRm>;
	Wed, 11 Jul 2001 12:17:42 -0400
Date: Wed, 11 Jul 2001 09:14:48 -0700
From: Greg KH <greg@kroah.com>
To: Richard Purdie <rpurdie@cableinet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Message-ID: <20010711091448.F28273@kroah.com>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com>; from rpurdie@cableinet.co.uk on Wed, Jul 11, 2001 at 04:11:09PM +0100
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 04:11:09PM +0100, Richard Purdie wrote:
> 
> I'm trying to get Linux to work with an Alcatel Speedtouch ADSL USB modem.
> By executing the following script after boot up I get the BUG message after
> running pppd.

Have you tried asking the author of the speedtouch driver about this?

greg k-h
