Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264999AbTFCNMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265001AbTFCNMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:12:46 -0400
Received: from unthought.net ([212.97.129.24]:15313 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S264999AbTFCNMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:12:42 -0400
Date: Tue, 3 Jun 2003 15:26:09 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Message-ID: <20030603132609.GE14947@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Michael Frank <mflt1@micrologica.com.hk>,
	linux-kernel@vger.kernel.org
References: <200306031912.53569.mflt1@micrologica.com.hk> <200306032043.28141.mflt1@micrologica.com.hk> <20030603125247.GD14947@unthought.net> <200306032101.27215.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306032101.27215.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 09:01:27PM +0800, Michael Frank wrote:
> On Tuesday 03 June 2003 20:52, Jakob Oestergaard wrote:
> >
> > I always use hard,intr so that I can manually interrupt hanging jobs,
> > but also know that they do not randomly fail just because a few packets
> > get dropped on my network.  This seems to be the common setup, as far as
> > I know.
> >
> 
> Thank you,
> 
> I will try hard, intr

no prob.

Please let the list know if it solves your problem or not - I'm sure
there are people who want to know if it doesn't, and if it does then the
solution will be in the archives for the next to find.

After all, I could be mistaken...  naaahh...   ;)

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
