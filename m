Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTHUWfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTHUWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 18:35:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262575AbTHUWfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 18:35:32 -0400
Message-ID: <3F45490B.5000505@zytor.com>
Date: Thu, 21 Aug 2003 15:34:51 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: "Bryan O'Sullivan" <bos@serpentine.com>, Jeff Garzik <jgarzik@pobox.com>,
       gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
Subject: Re: Initramfs
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <1061490490.23060.9.camel@serpentine.internal.keyresearch.com> <20030821190358.GF454@parcelfarce.linux.theplanet.co.uk> <1061495854.23060.12.camel@serpentine.internal.keyresearch.com> <20030821205656.GG454@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030821205656.GG454@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Thu, Aug 21, 2003 at 12:57:34PM -0700, Bryan O'Sullivan wrote:
> 
>>On Thu, 2003-08-21 at 12:03, viro@parcelfarce.linux.theplanet.co.uk
>>wrote:
>>
>>>RTFM.  cpio -o -H newc should be used to create an archive; _not_ the
>>>"binary" format that is default.
>>
>>There is no FM to R in this regard.
> 
> Ouch.  My apologies - I'd assumed that it got into the tree and hadn't
> checked that.  Google for "initramfs buffer spec" will give the text
> I had in mind.  Probably ought to go in Documentation/*, unless hpa
> has any problems with it.  Peter?

I concur wholeheartedly.

	-hpa

