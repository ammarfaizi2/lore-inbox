Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTJNIj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 04:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbTJNIj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 04:39:59 -0400
Received: from molly.vabo.cz ([160.216.153.99]:30991 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S262240AbTJNIj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 04:39:57 -0400
Date: Tue, 14 Oct 2003 10:39:33 -0400 (EDT)
From: Tomas Konir <moje@vabo.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7 USB and Palm Tungsten problem
In-Reply-To: <20031013194616.GA11679@kroah.com>
Message-ID: <Pine.LNX.4.58.0310141038570.2938@moje.vabo.cz>
References: <Pine.LNX.4.58.0310131855060.2551@moje.vabo.cz>
 <20031013194616.GA11679@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Greg KH wrote:

> On Mon, Oct 13, 2003 at 07:06:49PM -0400, Tomas Konir wrote:
> > 
> > Hi
> > I tried 2.6.0-test7, but new USB problem found. I tried to synchronize the 
> > palm Tungsten T over USB cradle. None happend, only short message about 
> > palm connected in log. Plug out the palm, but the visor module remained 
> > busy (count=1) and when i tried to rmmod uhci-hcd the rmmod stay in D 
> > state.
> 
> Try the patch below.  It should fix the problem for you.  If not, please
> let me know.
> 

It works
thank you.

	MOJE


-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

