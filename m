Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKVLTg>; Wed, 22 Nov 2000 06:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQKVLT1>; Wed, 22 Nov 2000 06:19:27 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:39414 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129150AbQKVLTO>;
	Wed, 22 Nov 2000 06:19:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001121142616.L7764@sventech.com> 
In-Reply-To: <20001121142616.L7764@sventech.com>  <20001121095626.F3431@valinux.com> <Pine.LNX.4.30.0011211912490.22252-100000@imladris.demon.co.uk> 
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Oleg Drokin <green@ixcelerator.com>, linux-kernel@vger.kernel.org
Subject: Re: hardcoded HZ in hub.c 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 10:48:35 +0000
Message-ID: <4627.974890115@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


johannes@erdfelt.com said:
>  Multiple seconds in the worst case. 

Well, I think the PCMCIA socket drivers would be happy with that. Depends 
what akpm also added to the list of tasks, and whether Linus actually puts 
that patch into test12.

Probably best to leave it for now and think about it in 2.5.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
