Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSDKPhn>; Thu, 11 Apr 2002 11:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314093AbSDKPhl>; Thu, 11 Apr 2002 11:37:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18051 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S314085AbSDKPh0>; Thu, 11 Apr 2002 11:37:26 -0400
Date: Thu, 11 Apr 2002 11:39:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@redhat.com>
cc: abraham@2d3d.co.za, linux-kernel@vger.kernel.org
Subject: Re: CHECKSUM_HW not behaving as expected
In-Reply-To: <20020411.082811.127950223.davem@redhat.com>
Message-ID: <Pine.LNX.3.95.1020411113911.14642A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, David S. Miller wrote:

> 
> The CRC is not his problem, ipv4 will truncate it off it is
> there.  In any event, see my other email, he thinks CHECKSUM_HW is
> CHECKSUM_UNNECESSARY due to a bug in Rubinni's book.
> 

Okay. Good.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

