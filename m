Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUBOSxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 13:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBOSxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 13:53:34 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:47108 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265170AbUBOSxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 13:53:34 -0500
Date: Sun, 15 Feb 2004 18:53:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Saout <christophe@saout.de>
Cc: Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Message-ID: <20040215185331.A8719@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christophe Saout <christophe@saout.de>,
	Michal Kwolek <miho@centrum.cz>, jmorris@redhat.com,
	linux-kernel@vger.kernel.org
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net> <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1076870572.20140.16.camel@leto.cs.pocnet.net>; from christophe@saout.de on Sun, Feb 15, 2004 at 07:42:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 07:42:53PM +0100, Christophe Saout wrote:
> > What's holding it back?  I'd rather get rid of all the cryptoloop crap
> > sooner or later.
> 
> Well, nothing. It's in the dm-unstable tree for some time now. It
> depends on when Joe plans to submit it. His last words were "in the next
> couple of months". I don't know what that means exactly.

Is there a technical reason holding it back, e.g. a depency on core DM
changes?  If not please submit it instead of waiting any longer.

