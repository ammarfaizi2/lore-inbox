Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270266AbSISHb7>; Thu, 19 Sep 2002 03:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270269AbSISHb7>; Thu, 19 Sep 2002 03:31:59 -0400
Received: from dsl-213-023-020-102.arcor-ip.net ([213.23.20.102]:65422 "EHLO
	starship") by vger.kernel.org with ESMTP id <S270266AbSISHb7>;
	Thu, 19 Sep 2002 03:31:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Greg KH <greg@kroah.com>, Brad Hards <bhards@bigpond.net.au>
Subject: Re: 2.5.26 hotplug failure
Date: Thu, 19 Sep 2002 09:37:07 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Duncan Sands <duncan.sands@wanadoo.fr>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <200209181715.51314.bhards@bigpond.net.au> <20020918165532.GA9654@kroah.com>
In-Reply-To: <20020918165532.GA9654@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17rvs3-0000uN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 18:55, Greg KH wrote:
> Sorry, but I'm not going to put the file back.  I understand your
> concerns.  We should have some kind of program (lsdev like) that shows
> the system information present at that moment in time.  It will be able
> to provide what the /proc/bus/usb/drivers file showed in the past.

How about calling it /proc/bus/usb/drivers?

-- 
Daniel
