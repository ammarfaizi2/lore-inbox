Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbTESWmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263186AbTESWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:42:54 -0400
Received: from aneto.able.es ([212.97.163.22]:41182 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263183AbTESWmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:42:53 -0400
Date: Tue, 20 May 2003 00:55:42 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org,
       lm@bitmover.com, cs@tequila.co.jp
Subject: Re: [PATCH] Documentation for iostats
Message-ID: <20030519225542.GE6096@werewolf.able.es>
References: <200305192118.h4JLIu710201@owlet.beaverton.ibm.com> <20030519154858.3b3e2677.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030519154858.3b3e2677.akpm@digeo.com>; from akpm@digeo.com on Tue, May 20, 2003 at 00:48:58 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.20, Andrew Morton wrote:
> Rick Lindsley <ricklind@us.ibm.com> wrote:
> >
> > As promised, here is a file to add to the Documentation/ directory which
> > describes the disk statistics fields.
> 
> Could we have /proc/diskstats too?
> 
> > +Last modified 5/15/03
> 
> Pet peeve number 4,592: There is no fifteenth month.
> 

How about using ISO dates to avoid this confussions ?
Last modified: 20030515


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc2-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
