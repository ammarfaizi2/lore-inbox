Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTEEOVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTEEOVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:21:46 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:3083 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262267AbTEEOVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:21:45 -0400
Date: Mon, 5 May 2003 15:34:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505153414.A24056@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no> <20030505112531.B16914@infradead.org> <1052133798.2821.122.camel@pc-16.office.scali.no> <20030505135211.A21658@infradead.org> <1052142082.2821.169.camel@pc-16.office.scali.no> <20030505144353.B23483@infradead.org> <1052142626.2821.173.camel@pc-16.office.scali.no> <20030505145519.A23727@infradead.org> <3EB674F7.8060807@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB674F7.8060807@gmx.net>; from c-d.hailfinger.kernel.2003@gmx.net on Mon, May 05, 2003 at 04:28:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 04:28:08PM +0200, Carl-Daniel Hailfinger wrote:
> LSM?

LSM is explicitly not syscall hooks.  And educated readers of lkml should
now my opinion on LSM...

