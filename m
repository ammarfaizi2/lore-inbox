Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267712AbRGPVmm>; Mon, 16 Jul 2001 17:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbRGPVmX>; Mon, 16 Jul 2001 17:42:23 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:40454 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S267712AbRGPVmU>; Mon, 16 Jul 2001 17:42:20 -0400
Date: Mon, 16 Jul 2001 17:42:18 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: "Tim R. Young" <try@lyang.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: cpu id?
In-Reply-To: <20010716143105.A728@box.lyang.net>
Message-ID: <Pine.LNX.4.33.0107161741470.14084-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Tim R. Young wrote:

> Hi,
>
> I need a user space tool to read out cpu id.
> Or documnent that specifies the interface in kernel.
> Thanks in advance.
>
> - T.

cat /proc/cpuinfo

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


