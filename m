Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbTEELVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTEELVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:21:05 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57744 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262138AbTEELVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:21:04 -0400
Date: Mon, 5 May 2003 11:33:30 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505113330.B8615@devserv.devel.redhat.com>
References: <1052122784.2821.4.camel@pc-16.office.scali.no> <20030505092324.A13336@infradead.org> <1052127216.2821.51.camel@pc-16.office.scali.no> <20030505112531.B16914@infradead.org> <1052133798.2821.122.camel@pc-16.office.scali.no> <1052134278.2821.131.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1052134278.2821.131.camel@pc-16.office.scali.no>; from terje.eggestad@scali.com on Mon, May 05, 2003 at 01:31:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 01:31:19PM +0200, Terje Eggestad wrote:
> In all fairness this should be done in glibc,

... or a LD_PRELOAD library......
