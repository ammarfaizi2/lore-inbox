Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272119AbTG2U7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272125AbTG2U7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:59:22 -0400
Received: from [62.29.72.36] ([62.29.72.36]:9857 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S272119AbTG2U7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:59:19 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: Roger Larsson <roger.larsson@norran.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1
Date: Wed, 30 Jul 2003 00:01:36 +0300
User-Agent: KMail/1.5.9
Cc: Davide Libenzi <davidel@xmailserver.org>
References: <20030727233716.56fb68d2.akpm@osdl.org> <200307290833.02848.kde@myrealbox.com> <200307292159.17137.roger.larsson@norran.net>
In-Reply-To: <200307292159.17137.roger.larsson@norran.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-1=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200307300001.36677.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 July 2003 22:59, Roger Larsson wrote:

> Is mplayer suid root? (allow SCHED_FIFO/RR usage)
> To get the equivalent function you need artswrapper to be suid root,
> and "Run soundserver with realtime priority" feature enabled in aRTs
> config.
>
No and aRts is running as root, I will check buffer size thing.


/cartman
