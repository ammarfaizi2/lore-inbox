Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263559AbTICG2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTICG2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:28:48 -0400
Received: from molly.vabo.cz ([160.216.153.99]:57860 "EHLO molly.vabo.cz")
	by vger.kernel.org with ESMTP id S263559AbTICG2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:28:46 -0400
Date: Wed, 3 Sep 2003 08:28:59 +0200 (CEST)
From: Tomas Konir <moje@vabo.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org
Subject: Re: 2.4.22 + XFS oops with palm usb sync
In-Reply-To: <20030903002743.GA21349@kroah.com>
Message-ID: <Pine.LNX.4.53.0309030826060.26355@moje.vabo.cz>
References: <Pine.LNX.4.53.0309022000260.7734@moje.vabo.cz>
 <20030903002743.GA21349@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003, Greg KH wrote:

> On Tue, Sep 02, 2003 at 08:07:09PM +0200, Tomas Konir wrote:
> > 
> > Hi
> > 2.4.22 periodically oops after synchronization my palm (Tungsten T).
> > Only XFS patches in kernel and no other. On usb was palm and Microsoft 
> > mouse. (sometimes with previous kernels the mouse was disconnected after 
> > synchronization). 
> 
> Known bug, sorry.  Use 2.6 instead.
> 
> Search the archives for details on what needs to be backported to 2.4 if
> you really want to fix this problem.
> 
> Good luck,

2.6.0-test4 sometimes hang up complete USB and all processes trying 
to work with modules stay in D state. This is not very usable.
(no messages in log).

	MOJE

-- 
Konir Tomas
Czech Republic
Brno
ICQ 25849167

