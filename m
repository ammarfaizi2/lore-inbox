Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRI2Whc>; Sat, 29 Sep 2001 18:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRI2WhM>; Sat, 29 Sep 2001 18:37:12 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:2575 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S271777AbRI2WhL>;
	Sat, 29 Sep 2001 18:37:11 -0400
Date: Sat, 29 Sep 2001 15:21:29 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Anders Eriksson <ander@milou.dyndns.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC (patch below) Re: ide drive problem? 
In-Reply-To: <200109292115.f8TLFMm29146@milou.dyndns.org>
Message-ID: <Pine.LNX.4.31.0109291520250.8143-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cat /proc/ide/hda/smart_values
cat /proc/ide/hda/smart_thresholds

Does that work?

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Sat, 29 Sep 2001, Anders Eriksson wrote:

>
> On boot my bios reports the disks as "S.M.A.R.T. Capable but
> disabled". Any pointer to where I can read up on this? (the bios
> settings gives nothing).
>
> /Anders
>
>
> >>>>> On Sat, 29 Sep 2001, "Andre" == Andre Hedrick wrote:
>
>   Andre> Sorry ABORTED commands are reported ad valid errors.  The
>   Andre> case of SMART errors is that SMART may not be enabled in the
>   Andre> device.
>
>
>
>

