Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUACMyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUACMyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:54:51 -0500
Received: from dyn-213-36-173-35.ppp.tiscali.fr ([213.36.173.35]:33542 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S262015AbUACMyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:54:50 -0500
Date: Sat, 3 Jan 2004 13:54:33 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev - please help me to understand
Message-Id: <20040103135433.09eb97b7.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20040103010010.GA14823@werewolf.able.es>
References: <microsoft-free.87r7yiinaj.fsf@eicq.dnsalias.org>
	<20040102202316.GD4992@kroah.com>
	<20040103010010.GA14823@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004 02:00:10 +0100
"J.A. Magallon" <jamagallon@able.es> wrote: 
> IE, I want a working and race free devfs, and this is udev.

Well udev != devfs. I think it's two different ways to solve a same problem.
What I wonder now is why do we need both /proc and sysfs?

-- 
Jabber: heimdal@jabber.org
