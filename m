Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVFWII6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVFWII6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVFWIGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:06:52 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:25765 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262383AbVFWGgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:36:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cv0Vh5dmiJXxOxS+ycxsfTH8D9wiEkCEShdvslrI1eym6Z9R1jEWC3lNkyaXAXTR9FSgeT0kfcB101iSnlGMMcE2pOEky3o9mX7/HCC4K0i85qCFBki8Z/jXp0ZjQiRzD3UQmoCuszrwWCB+yLcN2+X1lDR4JJwXJxc7ZJa9qII=
Message-ID: <fc339e4a05062223365c2a5ed5@mail.gmail.com>
Date: Thu, 23 Jun 2005 15:36:11 +0900
From: Miles Bader <snogglethorpe@gmail.com>
Reply-To: snogglethorpe@gmail.com, miles@gnu.org
To: Greg KH <greg@kroah.com>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Cc: Miles Bader <miles@gnu.org>, Mike Bell <kernel@mikebell.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050623062627.GB11638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050621062926.GB15062@kroah.com>
	 <20050620235403.45bf9613.akpm@osdl.org>
	 <20050621151019.GA19666@kroah.com>
	 <20050623010031.GB17453@mikebell.org>
	 <20050623045959.GB10386@kroah.com>
	 <buoaclhwqfj.fsf@mctpc71.ucom.lsi.nec.co.jp>
	 <20050623062627.GB11638@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Greg KH <greg@kroah.com> wrote:
> Not that I know of.  If you want to do this, compare the original udev
> releases that were around 5kb of code, as the nice features it has today
> are stuff that devfs can not support at all.

That wouldn't be such an effective tool for convincing people to
switch though... :-)  "Look this obsolete version is much smaller!"

If udev has really bloated up due to whizzy new features, how hard
would it be to compile a stripped-down version?  [Well I should look
at the busybox support somebody mentioned -- perhaps it's exactly
that.]

-Miles
-- 
Do not taunt Happy Fun Ball.
