Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263386AbRFAFQ2>; Fri, 1 Jun 2001 01:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263392AbRFAFQS>; Fri, 1 Jun 2001 01:16:18 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:3848 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263391AbRFAFQH>;
	Fri, 1 Jun 2001 01:16:07 -0400
Date: Thu, 31 May 2001 22:16:05 -0700
From: Greg KH <greg@kroah.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 2.4.5-ac4 security holes
Message-ID: <20010531221605.A14694@kroah.com>
In-Reply-To: <200106010449.VAA17373@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106010449.VAA17373@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Thu, May 31, 2001 at 09:49:14PM -0700
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:49:14PM -0700, Dawson Engler wrote:
> ---------------------------------------------------------
> [BUG]  fixed in ac5, I believe.
> /u2/engler/mc/oses/linux/2.4.5-ac4/drivers/usb/bluetooth.c:438:bluetooth_write: ERROR:PARAM:461:438: Deref tainted var 'buf' (tainted from line 461)

Yes it is.

greg k-h
