Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSGJVYP>; Wed, 10 Jul 2002 17:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSGJVYO>; Wed, 10 Jul 2002 17:24:14 -0400
Received: from vitelus.com ([64.81.243.207]:35591 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S317627AbSGJVYO>;
	Wed, 10 Jul 2002 17:24:14 -0400
Date: Wed, 10 Jul 2002 14:26:56 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac1
Message-ID: <20020710212656.GA20585@vitelus.com>
References: <200207091433.g69EXGl04767@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091433.g69EXGl04767@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 10:33:16AM -0400, Alan Cox wrote:
> o	HPT37x crash on init fixups			(Vojtech Pavlik)

FWIW I'm still experiencing this. With both 2.4.18-ac3 and
2.4.19-rc1-ac enabling the HPT driver causes the system to hang on
boot with a HPT370 card. When the driver  is NOT enabled,  the card
actually works (weird).
