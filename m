Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTLJTX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTLJTX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:23:59 -0500
Received: from dyn-213-36-224-2.ppp.tiscali.fr ([213.36.224.2]:3588 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S263885AbTLJTX6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:23:58 -0500
Date: Wed, 10 Dec 2003 20:23:54 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: mru@kth.se (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-Id: <20031210202354.7a3c429a.witukind@nsbm.kicks-ass.org>
In-Reply-To: <yw1xd6ayib3f.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org>
	<20031208154256.GV19856@holomorphy.com>
	<3FD4CC7B.8050107@nishanet.com>
	<20031208233755.GC31370@kroah.com>
	<20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
	<20031209075619.GA1698@kroah.com>
	<1070960433.869.77.camel@nomade>
	<20031209090815.GA2681@kroah.com>
	<buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<yw1xd6ayib3f.fsf@kth.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 10:39:32 +0100
mru@kth.se (Måns Rullgård) wrote:
> > Is there a specific case for which people want this feature?
> > Offhand it seems like a slightly odd thing to ask for...
> 
> I believe the original motivation for module autoloading was to save
> memory by unloading modules when their devices were unused.  Loading
> them automatically on demand made for less trouble for users, who
> didn't have to run modprobe manually to use the sound card, or
> whatever.  This could still be a good thing in embedded systems.
> 

I don't see why it wouldn't be a good thing for regular systems also. Saving
memory is usually a good idea.

-- 
Jabber: heimdal@jabber.org
