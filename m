Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUFQIr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUFQIr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266424AbUFQIr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:47:58 -0400
Received: from [213.146.154.40] ([213.146.154.40]:7080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266420AbUFQIrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:47:47 -0400
Date: Thu, 17 Jun 2004 09:47:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Christoph Hellwig <hch@infradead.org>, davids@webmaster.com,
       erikharrison@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Message-ID: <20040617084741.GA28595@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oliver Neukum <oliver@neukum.org>, davids@webmaster.com,
	erikharrison@gmail.com, linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKIEKKMKAA.davids@webmaster.com> <200406170045.32844.oliver@neukum.org> <20040617075926.GA27938@infradead.org> <200406171043.40533.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406171043.40533.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 10:43:40AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 17. Juni 2004 09:59 schrieb Christoph Hellwig:
> > On Thu, Jun 17, 2004 at 12:45:32AM +0200, Oliver Neukum wrote:
> > > This all boils down to the question of whether fimware is code or not.
> > 
> > No, that's exactly the political discussion we don't want to discuss here.
> > The keyspan case is worse where a file used in the kernel built has a
> > GPL-incompatible license.
> 
> Then go hence and convert the driver to the sysfs firmware interface,
> but please, please take the legalese off this list.

Umm, we ship something that isn't GPL-compatible.  Whenever I found
something like that (GFDL documentation, headers from vendor SDKs,
strange license text) we got that solved easily.  Now because it's the
magic firmware crap we shouldn't care anymore.

And no, I'm not going to convert it.  I'm not a usb person and I couldn't
test it.  If one of you usb guys want to convert it that's fine, if we
get the files relicensed under a GPL-compatible license that's fine aswell,
else I'll send a removal patch to Linus.

Stop beeing sloppy about copyrights.

