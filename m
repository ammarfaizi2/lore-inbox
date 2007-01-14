Return-Path: <linux-kernel-owner+w=401wt.eu-S1751346AbXANQnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXANQnS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbXANQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 11:43:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54807 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbXANQnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 11:43:17 -0500
Subject: Re: licence for LGPLed files
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Love <fx@gnu.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0701141430220.26276@yvahk01.tjqt.qr>
References: <rzqr6txbylk.fsf@loveshack.ukfsn.org>
	 <Pine.LNX.4.61.0701141430220.26276@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 14 Jan 2007 08:43:12 -0800
Message-Id: <1168792992.3123.918.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 14:32 +0100, Jan Engelhardt wrote:
> >There are various files (in my copy of the Ubuntu 2.6.15 source) which
> >have an LGPL licence, but there isn't a copy of the licence in the
> >distribution as there should be.  Changing them to GPL seems the best
> >thing to do.
> 
> Changing them to GPL seems the hardest and most instrusive thing to do.

well technically they don't need to be changed at all because they ARE
gpl as long as they're part of the kernel effectively (LGPL has that
"conversion to GPL" clause) ; only when used outside they are actually
lgpl....

also most of the files in question are header files where LGPL actually
makes sense when those same headers are used in userspace...

so how about not changing anything since there is no  need to change..



