Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbTHULjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbTHULjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:39:18 -0400
Received: from mail2.uu.nl ([131.211.16.76]:49616 "EHLO mail2.uu.nl")
	by vger.kernel.org with ESMTP id S262471AbTHULjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:39:12 -0400
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030821130131.A15398@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain>
	 <20030821010812.A6961@electric-eye.fr.zoreil.com>
	 <1061452050.4235.222.camel@shrek.bitfreak.net>
	 <20030821130131.A15398@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Message-Id: <1061466016.4234.230.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 21 Aug 2003 13:40:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

On Thu, 2003-08-21 at 13:01, Francois Romieu wrote:
> Ronald Bultje <rbultje@ronald.bitfreak.net> :
> > There is no variable 'channel' in these functions. I've double checked
> > these functions, too, and can't find any obvious leaks in them at all.
> > Could you please re-check?
> 
> Oops, cerebral traffic jam.
> 
> It should have read "client", not "channel".

Got it, thanks. Patches will show up in a few days.

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>
Linux Video/Multimedia developer

