Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUH1UhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUH1UhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUH1Ugg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 16:36:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:3761 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267973AbUH1URN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 16:17:13 -0400
Subject: Re: [patch] 2.6.9-rc1-mm1: megaraid_mbox.c compile error with gcc
	3.4
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>, bunk@fs.tum.de, sreenib@lsil.com,
       Manojj@lsil.com, linux-kernel <linux-kernel@vger.kernel.org>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
In-Reply-To: <20040828130419.57a56cdd.akpm@osdl.org>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC9BB@exa-atlanta>
	 <20040828130419.57a56cdd.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1093724235.8611.67.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 16:17:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 16:04, Andrew Morton wrote:
> "Mukker, Atul" <Atulm@lsil.com> wrote:
> >
> > The driver and the patches with the re-ordered functions is available at
> >  ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.3.1/
> 
> I dunno about James, but I *really* dislike receiving patches by going and
> getting them from internet servers.  It breaks our commonly-used tools.  It
> loses authorship info.  It loses Signed-off-by: info.  There is no
> changelog.  All this means that your patch is more likely to be ignored by
> busy people.  Please, just email the diffs.
> 

The FAQ should be updated, as it recommends posting a link to large
patches, rather than splitting them up and posting that way.

Of course, there is a lot in the FAQ that needs updating...

Lee

