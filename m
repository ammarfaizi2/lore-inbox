Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289906AbSAWQoY>; Wed, 23 Jan 2002 11:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289907AbSAWQoO>; Wed, 23 Jan 2002 11:44:14 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:52509 "EHLO
	wierzbowski.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289906AbSAWQn7>; Wed, 23 Jan 2002 11:43:59 -0500
Date: Wed, 23 Jan 2002 11:43:57 -0500
From: Bill Nottingham <notting@redhat.com>
To: Denis Oliver Kropp <dok@directfb.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NeoMagic Framebuffer Driver
Message-ID: <20020123114357.A29331@wierzbowski.devel.redhat.com>
Mail-Followup-To: Denis Oliver Kropp <dok@directfb.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020110161922.GA27357@skunk.convergence.de> <20020123132940.GA30417@skunk.convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020123132940.GA30417@skunk.convergence.de>; from dok@directfb.org on Wed, Jan 23, 2002 at 02:29:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Oliver Kropp (dok@directfb.org) said: 
> this version has a MODULE_LICENSE, applies fine to linux-2.4.18-pre6.

This seems to react rather badly when loaded from within X; I managed
to lock the machine trying to switch VCs after doing so (for example,
when I tried with matroxfb, it only screwed up the display.)

Yes, I know this falls into the 'don't *DO* that' category. :)

Bill
