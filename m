Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278574AbRJXPkD>; Wed, 24 Oct 2001 11:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278591AbRJXPjo>; Wed, 24 Oct 2001 11:39:44 -0400
Received: from proxy.povodiodry.cz ([212.47.5.214]:35066 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S278590AbRJXPjh>;
	Wed, 24 Oct 2001 11:39:37 -0400
From: "Vitezslav Samel" <samel@mail.cz>
Date: Wed, 24 Oct 2001 17:40:11 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
Message-ID: <20011024174010.A603@pc11.op.pod.cz>
In-Reply-To: <E15wPed-0000HM-00@lttit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15wPed-0000HM-00@lttit>; from timtas@dplanet.ch on Wed, Oct 24, 2001 at 05:09:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

  This is MeToo(tm) message. Limits set to unlimited, glibc-2.2.2 compiled
against 2.4.0 headers.
  Booting into 2.4.10-ac10 kernel problem "solved".

> When I try to create a partition of 2GB using fdisk or parted, I get the
> error "File size limit exceeded (core dumped)". I already read about this
> error on the mailing list, but sadly not of any solution.
> 
> Has anybody got one?
> 
> Btw: If happend with fdisk from util-linux-2.10f until util-linux-2.11l.

  Looking forward to proper fix.

	Cheers,
		Vita
