Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbTHULIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbTHULIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:08:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:57814 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262628AbTHULIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:08:21 -0400
Date: Thu, 21 Aug 2003 13:01:31 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-test3 zoran driver update
Message-ID: <20030821130131.A15398@electric-eye.fr.zoreil.com>
References: <1061414594.1320.97.camel@localhost.localdomain> <20030821010812.A6961@electric-eye.fr.zoreil.com> <1061452050.4235.222.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061452050.4235.222.camel@shrek.bitfreak.net>; from rbultje@ronald.bitfreak.net on Thu, Aug 21, 2003 at 09:47:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje <rbultje@ronald.bitfreak.net> :
[...]
> There is no variable 'channel' in these functions. I've double checked
> these functions, too, and can't find any obvious leaks in them at all.
> Could you please re-check?

Oops, cerebral traffic jam.

It should have read "client", not "channel".

--
Ueimor
