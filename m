Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLWXIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTLWXH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:07:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37785 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262859AbTLWXF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:05:57 -0500
Date: Tue, 23 Dec 2003 23:05:55 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Rob Love'" <rml@ximian.com>,
       "'Jari Soderholm'" <Jari.Soderholm@edu.stadia.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: DEVFS is very good compared to UDEV
Message-ID: <20031223230555.GF4176@parcelfarce.linux.theplanet.co.uk>
References: <1072216884.6987.52.camel@fur> <008401c3c9a3$0d11abe0$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008401c3c9a3$0d11abe0$ca41cb3f@amer.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:21:03PM -0800, Hua Zhong wrote:

> But I do have sth fair to say about this "unmaintained" part.
> 
> >From my memory, at some point in time, somebody (Al Viro?) reviewed
> devfs code and flamed the author in public (klml), throwing lots of bad
> impolite words to him, which I think was the biggest reason that the
> author stopped maintaining it.

Oh, really?  That "flame in public" was after _many_ months of pointing
to the same problems in private - with zero effect.

If maintainer sits on exploitable holes for ~18 months and does not care to do
anything, his code is unmaintained.  If same maintainer keeps pretending in
public that everything is fine, he can expect to have the truthfulness of his
statements challenged.  Also in public.  If the situation persists even after
that, then yes, there will be rather unflattering things to say.

Don't delude yourself - critical parts of devfs had not been maintained for
quite a while before Richard had disappeared.  It's not the effect of flames
- it's their cause and it predates them by _far_.
