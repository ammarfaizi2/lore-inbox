Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVANAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVANAkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVANAgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:36:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:62638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261730AbVANAdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:33:38 -0500
Date: Thu, 13 Jan 2005 16:33:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Jack O'Quin" <joq@io.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Matt Mackall <mpm@selenic.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050113163329.J24171@build.pdx.osdl.net>
References: <20050111150556.S10567@build.pdx.osdl.net> <87y8ezzake.fsf@sulphur.joq.us> <20050112074906.GB5735@devserv.devel.redhat.com> <87oefuma3c.fsf@sulphur.joq.us> <20050113072802.GB13195@devserv.devel.redhat.com> <878y6x9h2d.fsf@sulphur.joq.us> <20050113210750.GA22208@devserv.devel.redhat.com> <1105651508.3457.31.camel@krustophenia.net> <20050113214320.GB22208@devserv.devel.redhat.com> <87oefs9a8z.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87oefs9a8z.fsf@sulphur.joq.us>; from joq@io.com on Thu, Jan 13, 2005 at 05:31:40PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jack O'Quin (joq@io.com) wrote:
> Otherwise, your rlimits proposal is fine.  I still think it puts more
> of a burden on the sysadmin, but nobody else seems to care about that.

Actually, I care.  However, I don't think the burden is really too
much greater.  It may put some extra burden on the how-to-audio writer.
But adding a group and editing /etc/security/limits.conf doesn't sound
too bad to me.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
