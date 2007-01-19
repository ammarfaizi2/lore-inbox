Return-Path: <linux-kernel-owner+w=401wt.eu-S965041AbXASKoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbXASKoV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 05:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbXASKoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 05:44:21 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:38627 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965041AbXASKoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 05:44:20 -0500
Message-ID: <45B0A077.6040407@aitel.hist.no>
Date: Fri, 19 Jan 2007 11:41:59 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DISCUSS] memory allocation method
References: <5d96567b0701150536j4c3c50abndec5155ddb53d4a1@mail.gmail.com>
In-Reply-To: <5d96567b0701150536j4c3c50abndec5155ddb53d4a1@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raz Ben-Jehuda(caro) wrote:
>
> 3. In 64bit machines , is it possible to allocate huge buffers , such
> as 30 GB of ram ?
Yes, that is one of the nice things about 64-bit machines.
No special cases - you sure can get 30GB if your machine
is equipped with that much.  Or you can get that
much virtual memory if you have enough swap . . .

Helge Hafting
