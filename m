Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSD0UHx>; Sat, 27 Apr 2002 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSD0UGa>; Sat, 27 Apr 2002 16:06:30 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:54963 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S314448AbSD0UFt>;
	Sat, 27 Apr 2002 16:05:49 -0400
Date: Sat, 27 Apr 2002 21:05:45 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Matthew M <matthew.macleod@btinternet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Microcode update driver
In-Reply-To: <m171QRZ-000Ga6C@Wasteland>
Message-ID: <Pine.LNX.4.33.0204272103590.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Matthew M wrote:
> microcode: CPU0 no microcode found! (sig=f0a, pflags=4)
>
> in the kernel log. I couldn't find any reference to this on google, and it's
> not urgent or anything; I just thought it might be helpful.
>

This simply means your CPU0 is uptodate, there is no need to update
anything. Don't worry about it.

Regards
Tigran

