Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWBRNhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWBRNhe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWBRNhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:37:33 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:23055 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751259AbWBRNha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:37:30 -0500
Date: Sat, 18 Feb 2006 13:37:15 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060218133715.GA8422@unjust.cyrius.com>
References: <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <Pine.LNX.4.64.0602122256130.6773@iabervon.org> <20060213062158.GA2335@kroah.com> <Pine.LNX.4.64.0602130244500.6773@iabervon.org> <20060213175142.GB20952@kroah.com> <d120d5000602131003l7bd1451bs64076475fdd6079c@mail.gmail.com> <Pine.LNX.4.64.0602131339140.6773@iabervon.org> <43F641A2.50200@tmr.com> <20060218120617.GA911@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218120617.GA911@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@infradead.org> [2006-02-18 12:06]:
> > It would be nice to have one place to go to find burners, and to have
> > the model information in that place.
> /proc/sys/dev/cdrom/info

Nice.  Is that a stable interface people can rely on (seems this me it
should rather be in sys)?  I maintain a tool in Debian to rip/encode
audio CDs with one command and we could use this file to find the CD
interface if it's not specified by the user.
-- 
Martin Michlmayr
tbm@cyrius.com
