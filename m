Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRHRXJz>; Sat, 18 Aug 2001 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRHRXJp>; Sat, 18 Aug 2001 19:09:45 -0400
Received: from mailc.telia.com ([194.22.190.4]:46844 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S269391AbRHRXJh>;
	Sat, 18 Aug 2001 19:09:37 -0400
Date: Sun, 19 Aug 2001 01:08:21 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx won't recompile.
Message-ID: <20010819010821.A614@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01081812570001.09229@bits.linuxball> <001901c12810$97ef3a70$020a0a0a@totalmef> <3B7EB162.5070207@nothing-on.tv> <01081817401000.01028@bits.linuxball> <010d01c12839$29751370$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010d01c12839$29751370$020a0a0a@totalmef>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Naeslund(f) <mag@fbab.net> wrote:

> Maybe youre using egcs ?
> I think that compiler is "old" from a 2.4.x (x>=6) point of view?

andre@sledgehammer:~$ grep 'egcs' devel/kernel/linux/Documentation/Changes
The recommended compiler for the kernel is egcs 1.1.2 (gcc 2.91.66), and it
<snip>
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
