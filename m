Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTE2RNz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTE2RNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:13:55 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:27704 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262427AbTE2RNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:13:52 -0400
Subject: Re: [PATCH] 2.5.70 tty_register_driver
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030529165623.GC19920@kroah.com>
References: <1054138158.2107.4.camel@diemos>
	 <1054150058.2025.18.camel@diemos> <1054218448.2099.5.camel@diemos>
	 <20030529165623.GC19920@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054229234.2747.5.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 May 2003 12:27:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 11:56, Greg KH wrote:
> On Thu, May 29, 2003 at 09:27:28AM -0500, Paul Fulghum wrote:
> > I have posted to lkml and to the originator of the
> > 2.5.70 patch, and have received no dissenting views.
> 
> Hm, I wasn't the originator of the 2.5.70 change in this area, that's Al
> Viro.  I suggest you run this by him first.
> 
> thanks,
> 
> greg k-h

Sorry, in the 2.5.70 announcement by Linus, I saw some
tty changes listed under your name.

It does look like Al Viro is responsible for
the changes in question.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


