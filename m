Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281801AbRKQSaA>; Sat, 17 Nov 2001 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281799AbRKQS3u>; Sat, 17 Nov 2001 13:29:50 -0500
Received: from AGrenoble-101-1-3-82.abo.wanadoo.fr ([193.253.251.82]:3456 "EHLO
	strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281797AbRKQS3i> convert rfc822-to-8bit; Sat, 17 Nov 2001 13:29:38 -0500
Message-ID: <3BF6AD42.105@wanadoo.fr>
Date: Sat, 17 Nov 2001 19:32:34 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: "Michael N. Lipp" <MNL@MNL.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 breaks NVIDIA-1.0-1541 console switching
In-Reply-To: <200111171745.fAHHjnZ02112@mnlpc.dtro.e-technik.tu-darmstadt.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael N. Lipp wrote:

> Hello,
> 
> when I upgraded to 2.4.14, I found that console-switching doesn't work
> anymore with the latest NVIDIA driver installed. When I try to return
> to the console from X11 the system simply hangs (this includes
> shutdown, which makes it a real problem). Reverting to 2.4.13 fixed
> things. Sorry I can't report more hints.

Are you using framebuffer ? A friend of mine had exactly the same
problem, and it went away when he disabled the framebuffer...

François


