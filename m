Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269718AbTGULw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbTGULwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:52:46 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:46066 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S269718AbTGULwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:52:31 -0400
Subject: Re: 2.6.0-test1 Cannot login in X or console
From: Martin Schlemmer <azarah@gentoo.org>
To: Jonathan Bastien-Filiatrault <Intuxicated_kdev@yahoo.ca>
Cc: Jan Dittmer <j.dittmer@portrix.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F1A6397.8040706@yahoo.ca>
References: <3F18B603.70405@yahoo.ca> <3F195E5D.50409@maine.rr.com>
	 <3F1983BF.4080600@yahoo.ca> <3F19B65A.6010606@maine.rr.com>
	 <3F1A244E.6000505@yahoo.ca> <3F1A5123.2080101@portrix.net>
	 <3F1A6397.8040706@yahoo.ca>
Content-Type: text/plain
Organization: 
Message-Id: <1058789247.5737.2.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 21 Jul 2003 14:07:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 11:40, Jonathan Bastien-Filiatrault wrote:
> Jan Dittmer wrote:
> 
> > just mount devpts to /dev/pts, iff you have devfs enabled.
> 
> Already did that, i cannot even login on the 80x25 console.
> 
> >
> > jan
> >
> This bug is preventing me from migrating !!!
> Any ideas on the cause of this problem ?
> 

Maybe try to boot 2.4 again, and see if you can get the
wiser by looking at the logs.


Regards,

-- 
Martin Schlemmer


