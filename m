Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313544AbSDEUj7>; Fri, 5 Apr 2002 15:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313545AbSDEUjt>; Fri, 5 Apr 2002 15:39:49 -0500
Received: from cannabis.daphnes.RO ([194.105.18.252]:3853 "HELO
	cannabis.daphnes.ro") by vger.kernel.org with SMTP
	id <S313544AbSDEUje>; Fri, 5 Apr 2002 15:39:34 -0500
Date: Fri, 5 Apr 2002 23:38:37 +0300 (EEST)
From: halfdead <halfdead@daphnes.ro>
X-X-Sender: <halfdead@daphnes.ro>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: weird IDT issue
In-Reply-To: <Pine.LNX.3.95.1020405150455.1257A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0204052332440.19204-100000@daphnes.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first of all, i get the correct idt base. the problem is i cannot
dereference it, to get the interrupt entry i`m interrested in. second, i
have tried to get the right segment by pushl %ss / popl %ds . it has the
same behaviour. i would apreciate if you`d be more clear .. thanks in
advance for your help.

- halfdead


