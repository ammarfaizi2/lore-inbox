Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJXWrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbTJXWp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:45:59 -0400
Received: from main.gmane.org ([80.91.224.249]:48273 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261973AbTJXWpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:45:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 00:45:08 +0200
Message-ID: <yw1xbrs6p85n.fsf@kth.se>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net>
 <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
 <20031023082534.GD643@openzaurus.ucw.cz> <yw1xr813f1a3.fsf@kth.se>
 <3F98FDDF.1040905@cyberone.com.au> <yw1xbrs6652m.fsf@kth.se>
 <20031024222347.GB728@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:8eVCkvgOte/j7d1pqSf7/K5vj8o=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Try it completely without modules. I'm not sure how it should work
> with modules which means it probably does not work at all.

Are you saying it doesn't work with any modules?  What about all the
people who have reported success with suspend-to-disk?  I thought
everyone used at least some modules.

-- 
Måns Rullgård
mru@kth.se

