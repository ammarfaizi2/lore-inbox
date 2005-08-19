Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbVHSVVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbVHSVVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965166AbVHSVVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:21:38 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:8988 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965161AbVHSVVh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:21:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+TGpF+oiA/107sIDl4YGwsOrPCM8jeCJ+wUQRAgHGNLRGEdL4FNEEc/YbDL8uWab16kwSxNGc9z2axo6Tjp8DXWNNsEpOtSY6XxlDI9RRv+yf7nHJlt2iuCT19yfggEm4krsi9hgIsGdqdkt7LCfM8Eoe88EUcxKyTWGacbY40=
Message-ID: <3aa654a405081914216b54d155@mail.gmail.com>
Date: Fri, 19 Aug 2005 14:21:35 -0700
From: Avuton Olrich <avuton@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050819211025.GB29476@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <3aa654a405081909427e033fd1@mail.gmail.com>
	 <20050819211025.GB29476@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/05, Greg KH <greg@kroah.com> wrote:
> On Fri, Aug 19, 2005 at 09:42:51AM -0700, Avuton Olrich wrote:
> > On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> > > - Lots of fixes, updates and cleanups all over the place.
> >
> > Problem: Badness during boot, seems to pertain to USB serial driver/gameport
> 
> Does this happen in 2.6.13-rc6 (no -mm)?
> 
> I'm trying to reproduce this now (Andrew, I didn't have any such build
> link errors like you did with this config...)

I can't test 2.6.13-rc6 atm, since I have dependance on REISER4_FS=Y

avuton
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
