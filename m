Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270121AbRHMMFQ>; Mon, 13 Aug 2001 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270120AbRHMMFF>; Mon, 13 Aug 2001 08:05:05 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:40927
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S270118AbRHMMEt>; Mon, 13 Aug 2001 08:04:49 -0400
Date: Mon, 13 Aug 2001 14:04:56 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange gcc crashes...
Message-ID: <20010813140456.R11653@jaquet.dk>
In-Reply-To: <E15WGJY-000Ecx-00@f12.port.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15WGJY-000Ecx-00@f12.port.ru>; from _deepfire@mail.ru on Mon, Aug 13, 2001 at 03:55:24PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2001 at 03:55:24PM +0400, Samium Gromoff wrote:
[...]
>  maybe 55 min is not enough for proper mem testing?

Not enough to be sure. I have had memtest86 report problems
only after 11 hours and only in a specific test. Others on
the list have reported memtest runs much longer that did
not find anything but still their gcc problems went away
after putting in new RAM.

For some reason gcc seems to be an excellent RAM tester ;)

Regards,
  Rasmus
