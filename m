Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272280AbTHIBXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272165AbTHIBJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:09:26 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:37017 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S272235AbTHIBHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:07:53 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: "Cho, joon-woo" <jwc@core.kaist.ac.kr>, <linux-kernel@vger.kernel.org>
Subject: Re: BT848 driver code
Date: Fri, 8 Aug 2003 22:08:34 -0300
User-Agent: KMail/1.5.1
References: <001f01c35d9e$3df295b0$a5a5f88f@core8fyzomwjks>
In-Reply-To: <001f01c35d9e$3df295b0$a5a5f88f@core8fyzomwjks>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308082208.34618.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

You may want to give a look at the Video4Linux2 specs:
http://bytesex.org/v4l/spec/

Lucas


On Friday 08 August 2003 08:14, Cho, joon-woo wrote:
> I think that data in BT848's memory is transferred to graphic card memory
>
> to show the captured data at monitor.
>
> Am i right?
>
> If right, what variable is pointed to graphic card memory  in device driver
> code?
>
> (I think in /drivers/media/video/bttv-driver.c)
>
> Or is memory  in graphic card managed by more complex scheme as page?
>
>
> Please answer, thanks.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

