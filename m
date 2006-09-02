Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWIBLvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWIBLvu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIBLvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:51:50 -0400
Received: from lns-th2-5f-81-56-194-193.adsl.proxad.net ([81.56.194.193]:1410
	"EHLO philou.philou.org") by vger.kernel.org with ESMTP
	id S1751087AbWIBLvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:51:49 -0400
Date: Sat, 2 Sep 2006 13:51:40 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= <philippe@gramoulle.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc5-mm1
In-Reply-To: <44F96DC7.5060805@s5r6.in-berlin.de>
References: <44F96DC7.5060805@s5r6.in-berlin.de>
X-Mailer: Sylpheed-Claws 2.4.0cvs79 (GTK+ 2.8.18; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Message-Id: <20060902115140.F3F0DCB1@philou.gramoulle.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stefan,

Thanks for the hint, it's building fine now.

Philippe

On Sat, 02 Sep 2006 13:40:55 +0200
Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

  | Philippe Gramoullé wrote:
  | ...
  | >   | ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/
  | > 
  | > 2.6.18-rc5-mm1 doesn't build whereas 2.6.18-rc5 does.
  | ...
  | > arch/i386/kernel/sys_i386.c:262: error: '__NR_execve' undeclared (first use in this function)
  | ...
  | 
  | Also apply the hot-fixes from above FTP link.
  | -- 
  | Stefan Richter
  | -=====-=-==- =--= ---=-
  | http://arcgraph.de/sr/

-- 
VGER BF report: H 0
