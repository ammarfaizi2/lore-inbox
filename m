Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTGKQyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbTGKQyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:54:54 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:15 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264455AbTGKQyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:54:25 -0400
Date: Fri, 11 Jul 2003 18:09:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711180901.A28202@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <Pine.SOL.4.30.0307111646470.9740-100000@mion.elka.pw.edu.pl> <20030711155843.GD2210@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030711155843.GD2210@gtf.org>; from jgarzik@pobox.com on Fri, Jul 11, 2003 at 11:58:43AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 11:58:43AM -0400, Jeff Garzik wrote:
> I like arjan's "fakeraid" or "ataraid" names.  ;-)

I'd prefer fakeraid because this describes it best.
It's a software raid that wants to look like hardware raid to
(windows) users.
