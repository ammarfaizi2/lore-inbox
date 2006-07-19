Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWGSNwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWGSNwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 09:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWGSNwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 09:52:11 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:38405 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S964817AbWGSNwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 09:52:10 -0400
From: ocilent1 <ocilent1@gmail.com>
Reply-To: ocilent1@gmail.com
To: Hugo Vanwoerkom <rociobarroso@att.net.mx>
Subject: Re: sound skips on 2.6.16.17
Date: Wed, 19 Jul 2006 21:51:51 +0800
User-Agent: KMail/1.9.3
Cc: Chris Wedgwood <cw@f00f.org>, Lee Revell <rlrevell@joe-job.com>,
       Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, dsd@gentoo.org
References: <200606181204.29626.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org> <44BE37E8.2040706@att.net.mx>
In-Reply-To: <44BE37E8.2040706@att.net.mx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607192151.51553.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 July 2006 21:47, Hugo Vanwoerkom wrote:
> Chris Wedgwood wrote:
> > On Wed, Jul 19, 2006 at 02:03:25PM +0800, ocilent1 wrote:
> >> Hows progress on this bug? Don't suppose we have got an official fix
> >> for this somewhere on the horizon?
> >
> > Daniel Drake posted this recently, I've not had a chance to look over
> > it in detail but it's probably the best tested suggestion thus far.
> >
> > Does it work for you?
>
> <snip>
>
> I tried that on 2.6.17-ck1 with good results:
>
> ...
> patching file drivers/pci/quirks.c
> Hunk #1 succeeded at 638 (offset -10 lines).
> Hunk #2 succeeded at 678 (offset -10 lines).
> ...
>
> Regards,
>
> Hugo

Yep, I can also report that my sacrificial test user also said the patch works 
well on his VIA system.

Cheers!
-- 
*ocilent1
