Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUAZToL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264598AbUAZToL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 14:44:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:61705 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264549AbUAZToJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 14:44:09 -0500
Date: Mon, 26 Jan 2004 19:44:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ben Pfaff <blp@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cooperative Linux
Message-ID: <20040126194408.A3450@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ben Pfaff <blp@cs.stanford.edu>, linux-kernel@vger.kernel.org
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com> <slrnc193vo.42h.mozbugbox@mozbugbox.somehost.org> <87ektn2tkn.fsf@pfaff.stanford.edu> <20040126091900.A29544@infradead.org> <8765ey3as9.fsf@pfaff.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8765ey3as9.fsf@pfaff.stanford.edu>; from blp@cs.stanford.edu on Mon, Jan 26, 2004 at 09:00:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 09:00:22AM -0800, Ben Pfaff wrote:
> > On Sun, Jan 25, 2004 at 08:59:52PM -0800, Ben Pfaff wrote:
> >> For what it's worth, this has been done in the proprietary world
> >> as successful commercial software, as VMware ESX Server.
> >
> > Which seems to be nothing more than a hacked up Linux..
> 
> Not even close to true.  ESX Server includes a hacked up Linux as
> part of its front end, but there's a lot more than that.

Well, I've only seen their driver API is the linux API with slight changes.
Can you elaborate what "includes a hacked up Linux as part of its front end"
means and where we can get the source to the rest of this frontend (and
the linux changes)?

