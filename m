Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbTCCOcM>; Mon, 3 Mar 2003 09:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTCCOcM>; Mon, 3 Mar 2003 09:32:12 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27793 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265423AbTCCOcL>; Mon, 3 Mar 2003 09:32:11 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303031442.h23EgbR02502@devserv.devel.redhat.com>
Subject: Re: Tighten up serverworks workaround.
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 3 Mar 2003 09:42:37 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030303134650.584c9f11.skraw@ithnet.com> from "Stephan von Krawczynski" at Mar 03, 2003 01:46:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We are a bit astonished since we expected serverworks-based hardware to perform
> _better_ than VIA...

My experience is that in general it does.

> The email you commented is only a small hint that within -pre5 there are still
> declared-unknown parts of the chipset. Based on the theory that they are named
> "unknown" because nobody around here knows them, it might have been an adequate
> idea to ask someone from serverworks, or not? This is in no way meant offensive.

Sure, but lets not give senior folks at Serverworks a full blast of l/k.
Its better to sumarise the issues. In some cases vendors do have docs,
so the unknown device ids missing from lspci for example can be dealt with
outside already
