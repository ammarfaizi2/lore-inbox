Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVHKIVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVHKIVG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVHKIVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:21:05 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:25215 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932290AbVHKIVE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:21:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iwzApJ5/e1FJMASjR9sEdYQ23YBGRakHeF9UxJNnhVBOTPYyEY5WC8SRLDXL2CPsF+NRWStRZAsr5FUkHYk4HoQldgS2H/dMx0mrLlPVkx4qL3KCxnmVU2xfYVgDiNMOlxnWRgIG98yUdkbZK5AhwNImz2NRoRKm3axq/dK6GNU=
Message-ID: <bc57270905081101217fdd4c5f@mail.gmail.com>
Date: Thu, 11 Aug 2005 16:21:04 +0800
From: Michael <mikore.li@gmail.com>
To: linux clustering <linux-cluster@redhat.com>
Subject: Re: [Linux-cluster] GFS - updated patches
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050811081729.GB12438@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050802071828.GA11217@redhat.com>
	 <20050811081729.GB12438@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same question as I asked before, how can I see GFS in "make
menuconfig", after I patch gfs2-full.patch into a 2.6.12.2 kernel?

Michael

On 8/11/05, David Teigland <teigland@redhat.com> wrote:
> Thanks for all the review and comments.  This is a new set of patches that
> incorporates the suggestions we've received.
> 
> http://redhat.com/~teigland/gfs2/20050811/gfs2-full.patch
> http://redhat.com/~teigland/gfs2/20050811/broken-out/
> 
> Dave
> 
> --
> Linux-cluster mailing list
> Linux-cluster@redhat.com
> http://www.redhat.com/mailman/listinfo/linux-cluster
>
