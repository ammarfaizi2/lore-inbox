Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbUKDQqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbUKDQqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUKDQqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:46:07 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:36757 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S262289AbUKDQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:46:02 -0500
Subject: Re: is killing zombies possible w/o a reboot?
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, DervishD <lkml@dervishd.net>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
In-Reply-To: <200411041118.36204.gene.heskett@verizon.net>
References: <200411030751.39578.gene.heskett@verizon.net>
	 <200411031147.14179.gene.heskett@verizon.net>
	 <1099533471.3448.6.camel@crazytrain>
	 <200411041118.36204.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1099586824.3949.1.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 11:47:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 11:18, Gene Heskett wrote:

> And where is htop, it apparently isn't part of an FC2 install.
> >


http://htop.sourceforge.net/

from site above;
Comparison between htop and top
      * In 'htop' you can scroll the list vertically and horizontally to
        see all processes and complete command lines.
      * In 'top' you are subject to a delay for each unassigned key you
        press (especially annoying when multi-key escape sequences are
        triggered by accident).
      * 'htop' starts faster ('top' seems to collect data for a while
        before displaying anything).
      * In 'htop' you don't need to type the process number to kill a
        process, in 'top' you do.
      * In 'htop' you don't need to type the process number or the
        priority value to renice a process, in 'top' you do.
      * 'htop' supports mouse operation, 'top' doesn't
      * 'top' is older, hence, more used and tested.



cheers!

-fd

