Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVCWAhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVCWAhe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVCWAhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:37:34 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:24621 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262655AbVCWAha convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:37:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TaGE8AvIv8RzMGLRLfcCkkZ6o0VmKny/TpwDquobrK+4eaC5lB148oOqdEkn7rgHW/rTUUOC/uqmF7Mm5kattjIGWVb7gHrukShTY44Y+exvbvyH81O4Dj4G5pyQ4gXdVI5amvVJgfjldGSUX0ZnNjJJrbZQhRllbBaDheWt6iw=
Date: Wed, 23 Mar 2005 01:37:29 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-Id: <20050323013729.0f5cd319.diegocg@gmail.com>
In-Reply-To: <1110827273.14842.3.camel@mindpipe>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	<20050314083717.GA19337@elf.ucw.cz>
	<200503140855.18446.jbarnes@engr.sgi.com>
	<20050314191230.3eb09c37.diegocg@gmail.com>
	<1110827273.14842.3.camel@mindpipe>
X-Mailer: Sylpheed version 1.9.6+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 14 Mar 2005 14:07:53 -0500,
Lee Revell <rlrevell@joe-job.com> escribió:

> I'm really not trolling, but I suspect if we made the boot process less
> verbose, people would start to wonder more about why Linux takes so much
> longer than XP to boot.

By the way, Microsoft seems to be claiming that boot time will be reduced to the half
with Longhorn. While we already know how ms marketing team works, 50% looks
like a lot. Is there a good place to discuss what could be done in the linuxland to
improve things? It doesn't looks like a couple of optimizations will be enought...
