Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJUMPR>; Sun, 21 Oct 2001 08:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275983AbRJUMPH>; Sun, 21 Oct 2001 08:15:07 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:32778 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S275973AbRJUMPA>; Sun, 21 Oct 2001 08:15:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        Christoph Rohland <cr@sap.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
Date: Sun, 21 Oct 2001 08:15:33 -0400
X-Mailer: KMail [version 1.3.2]
Cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com> <3BD28673.1060302@sap.com> <20011021120755.A1252@parallab.uib.no>
In-Reply-To: <20011021120755.A1252@parallab.uib.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011021121504Z275973-17409+2176@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 06:07, Jan-Frode Myklebust wrote:
> On Sun, Oct 21, 2001 at 10:25:23AM +0200, Christoph Rohland wrote:
> >  > Last tested with Bitkeeper 2.0 on linux 2.4.10-xfs.
> >
> > Can you test it with 2.4.12?
>
> It's a bit painfull getting older versions of the XFS cvs-server (no
> tagging), so I fetched the latest 2.4.13-pre5-xfs kernel. Shows exactly the
> same problem.
>
>
>   -jf

Like someone said before a while ago.  This is a binutils problem.  Update to 
a newer version. 
