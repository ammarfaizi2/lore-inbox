Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUHKRMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUHKRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268123AbUHKRMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:12:09 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:55054 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268121AbUHKRMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:12:06 -0400
Date: Wed, 11 Aug 2004 18:11:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       James Ketrenos <jketreno@linux.intel.com>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040811181142.A30309@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tomas Szepe <szepe@pinerecords.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	James Ketrenos <jketreno@linux.intel.com>,
	Pavel Machek <pavel@suse.cz>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>, netdev@oss.sgi.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org> <411A478E.1080101@linux.intel.com> <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net> <20040811163333.GE10100@louise.pinerecords.com> <20040811175105.A30188@infradead.org> <20040811170208.GG10100@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040811170208.GG10100@louise.pinerecords.com>; from szepe@pinerecords.com on Wed, Aug 11, 2004 at 07:02:08PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:02:08PM +0200, Tomas Szepe wrote:
> Agreed.  But the point is, in the actual case of ipw2100, will the removal
> of 40 or so lines of code justify killing the functionality for those (lots)
> that use it?

Yes.

