Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274055AbRJTTR6>; Sat, 20 Oct 2001 15:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJTTRt>; Sat, 20 Oct 2001 15:17:49 -0400
Received: from questmail.futurequest.net ([63.95.221.251]:42251 "HELO
	questmail.futurequest.net") by vger.kernel.org with SMTP
	id <S274055AbRJTTRe>; Sat, 20 Oct 2001 15:17:34 -0400
Subject: Re: USB module ov511 dies after about 30 minutes
From: "Jeffrey H. Ingber" <axatax@thelittleman.net>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011020182257.513a36e7.skraw@ithnet.com>
In-Reply-To: <20011020182257.513a36e7.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 20 Oct 2001 15:18:02 -0400
Message-Id: <1003605486.1616.65.camel@eleusis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The OV511 module in the kernel, is unfortunately, extremely old.  You
should use the updated modules from (alpha.dyndns.org/ov511).

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)

On Sat, 2001-10-20 at 12:22, Stephan von Krawczynski wrote:
> Hello,
> 
> I have a webcam model creative webcam III. I read from it every minute. After
> about 30 minutes the module ov511 cannot be unloaded anymore, stopped working
> (of course, only black pictures are delivered) and there are no error messages
> what so ever. This can only be resolved by rebooting. Any hints?
> Used kernel 2.4.13-pre5.
> Used to work with 2.4.10.
> 
> Regards,
> Stephan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


