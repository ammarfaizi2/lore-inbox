Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTEMQss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTEMQss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:48:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:13832 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262280AbTEMQqp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:46:45 -0400
Date: Tue, 13 May 2003 18:59:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513165926.GA1170@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@oss.sgi.com>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk> <20030513163854.A27407@infradead.org> <20030513155047.GA30944@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513155047.GA30944@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 11:50:47AM -0400, Jeff Garzik wrote:
> mips definitely needs work.  I don't know that there exists a working
> 2.5 mips port.
> 
> I told Ralf I would work on getting it booting on my Indy, and have been
> slowly working through that.  There is also some mips work in the
> linux-mips cvs tree.

If I want to update mips Makefiles to new style - what should be used
as baseline?

Linus-BK or a mips cvs somewhere?

	Sam
