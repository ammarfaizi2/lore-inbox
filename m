Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281783AbRKQRao>; Sat, 17 Nov 2001 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281784AbRKQRae>; Sat, 17 Nov 2001 12:30:34 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:1694 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281783AbRKQRaR>;
	Sat, 17 Nov 2001 12:30:17 -0500
Message-ID: <3BF69ECF.7000905@stesmi.com>
Date: Sat, 17 Nov 2001 18:30:55 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Michael N. Lipp" <MNL@MNL.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> when I upgraded to 2.4.14, I found that console-switching doesn't work
> anymore with the latest NVIDIA driver installed. When I try to return
> to the console from X11 the system simply hangs (this includes
> shutdown, which makes it a real problem). Reverting to 2.4.13 fixed
> things. Sorry I can't report more hints.

Report the error to NVidia, it's their module and they don't distribute 
the source. It's difficult to help since the bug might be in their code.

// Stefan


