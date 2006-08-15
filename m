Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWHOQUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWHOQUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbWHOQUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:20:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:47580 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030379AbWHOQUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:20:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HCnQIDI0UXF7MmMdEMWolao+LdTxlh5DcZ/iuiCy2ROJySINnwY+AQmYPkPxd4kPpv6qgTnrIdvu7s2xifScfqd8EsF1CzNT0HTreMS5B9i7TIKo8s6qsrERmylYX8GILEbzcJsz05bpFv2mg+fJI+AQ6gr5xnkF1hq5Uhz4TmM=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/4] aic7xxx: remove excessive inlining
Date: Tue, 15 Aug 2006 18:20:21 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200608131457.21951.vda.linux@googlemail.com> <20060814161434.d643f568.akpm@osdl.org> <20060814162516.1a458ff9.rdunlap@xenotime.net>
In-Reply-To: <20060814162516.1a458ff9.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151820.21929.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 01:25, Randy.Dunlap wrote:
> On Mon, 14 Aug 2006 16:14:34 -0700 Andrew Morton wrote:
> 
> > On Sun, 13 Aug 2006 14:57:21 +0200
> > Denis Vlasenko <vda.linux@googlemail.com> wrote:
> > 
> > > This is a resend.
> > 
> > Please resend ;)
> > 
> > - All these patches had the same Subject:, thus forcing me to invent
> >   titles for you.  
> > 
> > - The changelogs are weird - think what they'll look like once they
> > hit the git tree.  Someone will need to clean those changelogs up,
> > and I'd prefer that it not be me.
> > 
> > - Missing Signed-off-by:'s.
> > 
> > http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt is here to
> > help.
> 
> Don't *zip them.

Ok, resending to Andrew off-list.
--
vda
