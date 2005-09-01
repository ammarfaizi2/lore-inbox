Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVIARVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVIARVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVIARVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:21:05 -0400
Received: from smtp.istop.com ([66.11.167.126]:47754 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1030249AbVIARVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:21:04 -0400
From: Daniel Phillips <phillips@istop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: GFS, what's remaining
Date: Thu, 1 Sep 2005 13:23:07 -0400
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-cluster@redhat.com
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain>
In-Reply-To: <1125586158.15768.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509011323.08217.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 September 2005 10:49, Alan Cox wrote:
> On Iau, 2005-09-01 at 03:59 -0700, Andrew Morton wrote:
> > - Why GFS is better than OCFS2, or has functionality which OCFS2 cannot
> >   possibly gain (or vice versa)
> >
> > - Relative merits of the two offerings
>
> You missed the important one - people actively use it and have been for
> some years. Same reason with have NTFS, HPFS, and all the others. On
> that alone it makes sense to include.

I thought that gfs2 just appeared last month.  Or is it really still just gfs?  
If there are substantive changes from gfs to gfs2 then obviously they have 
had practically zero testing, let alone posted benchmarks, testimonials, etc.  
If it is really still just gfs then the silly-rename should be undone.

Regards,

Daniel
