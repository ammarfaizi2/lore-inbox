Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTEENmw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTEENmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:42:52 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:57866 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262227AbTEENmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:42:50 -0400
Date: Mon, 5 May 2003 14:55:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505145519.A23727@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Terje Eggestad <terje.eggestad@scali.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no> <20030505112531.B16914@infradead.org> <1052133798.2821.122.camel@pc-16.office.scali.no> <20030505135211.A21658@infradead.org> <1052142082.2821.169.camel@pc-16.office.scali.no> <20030505144353.B23483@infradead.org> <1052142626.2821.173.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052142626.2821.173.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 03:50:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 03:50:26PM +0200, Terje Eggestad wrote:
> "Do you acknowledge a legitimate need to have syscall hooks?"

No.
