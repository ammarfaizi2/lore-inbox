Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbRFVU6f>; Fri, 22 Jun 2001 16:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265515AbRFVU6Y>; Fri, 22 Jun 2001 16:58:24 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:48940
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S265513AbRFVU6G>; Fri, 22 Jun 2001 16:58:06 -0400
Date: Fri, 22 Jun 2001 22:57:59 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, dwmw2@redhat.com,
        mtd@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup in drivers/mtd/ftl.c (245-ac16)
Message-ID: <20010622225759.F842@jaquet.dk>
In-Reply-To: <20010622222931.C842@jaquet.dk> <20010622172106.B3614@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010622172106.B3614@conectiva.com.br>; from acme@conectiva.com.br on Fri, Jun 22, 2001 at 05:21:06PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 05:21:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Rasmus,
> 
> 	I've fixed this ones and its already in 2.4.6-pre5, please take a
> look and see if something is missing.

These patches are very close so I'll of course retract mine[1].
The only thing I'll recommend is the printk I have in the error
path.

[1] Sorry about the unnecessary mailing. I am not accustomed to
janitor-like patches being in Linus' kernel before Alan's :)
(Arnaldo already offered an explanation for why this one happened
to be.)
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Smoking kills. If you're killed, you've lost a very important part of your
life.  -Brooke Shields, during an interview to become spokesperson for a
federal anti-smoking campaign.
