Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJIUAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTJIUAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:00:37 -0400
Received: from gaia.cela.pl ([213.134.162.11]:29965 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262070AbTJIUAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:00:36 -0400
Date: Thu, 9 Oct 2003 22:00:13 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Nuno Silva <nuno.silva@vgertech.com>
cc: herft <herft@sedal.usyd.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: CPU Usage for particular User Login
In-Reply-To: <3F8592D6.6090905@vgertech.com>
Message-ID: <Pine.LNX.4.44.0310092157290.30889-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You can also run a lot of top programs, each for one user (type 'u' 
> while in top).
> 
> Regards,
> Nuno Silva

nb. is their a way to get fair 'equal time / proc percentage per user' 
queueing of the CPU(s).

i.e. not limiting the number of processes/user but limiting the total CPU 
'power' in use by a given user, something like the CBQ network 
schedulers... perhaps with some classes (like root) more priveledged 
etc... or is this something for 2.7?

Cheers,
MaZe.

