Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUHXMp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUHXMp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 08:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUHXMp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 08:45:27 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61448 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267648AbUHXMp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 08:45:26 -0400
Date: Tue, 24 Aug 2004 13:45:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Christoph Hellwig <hch@infradead.org>, alan@lxorguk.ukuu.org.uk,
       wtogami@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
Message-ID: <20040824134519.A28587@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Markus Lidel <Markus.Lidel@shadowconnect.com>,
	alan@lxorguk.ukuu.org.uk, wtogami@redhat.com,
	linux-kernel@vger.kernel.org
References: <4123E171.3070104@shadowconnect.com> <20040819002448.A3905@infradead.org> <4123E73F.7040409@shadowconnect.com> <20040819104829.A7705@infradead.org> <41247E0E.8030005@shadowconnect.com> <20040819110635.A7850@infradead.org> <4124950B.1090706@shadowconnect.com> <20040823185554.B19476@infradead.org> <412AF97A.6070700@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <412AF97A.6070700@shadowconnect.com>; from Markus.Lidel@shadowconnect.com on Tue, Aug 24, 2004 at 10:16:58AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 10:16:58AM +0200, Markus Lidel wrote:
> > to reduce the clutter and get locking right, but for now that patch
> > should do it.
> 
> Could you maybe send me some hints because i want it to be it in 
> mainline kernel ASAP?

I don't thjink it's require for mainline inclusion, the new driver
already is a definit improvenet.  I'll send you more review comments
when I get a little bit more time.

