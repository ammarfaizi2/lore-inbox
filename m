Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSDEWPK>; Fri, 5 Apr 2002 17:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313649AbSDEWPA>; Fri, 5 Apr 2002 17:15:00 -0500
Received: from cannabis.daphnes.RO ([194.105.18.252]:13584 "HELO
	cannabis.daphnes.ro") by vger.kernel.org with SMTP
	id <S313038AbSDEWOv>; Fri, 5 Apr 2002 17:14:51 -0500
Date: Sat, 6 Apr 2002 01:13:59 +0300 (EEST)
From: halfdead <halfdead@daphnes.ro>
X-X-Sender: <halfdead@daphnes.ro>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: weird IDT issue
In-Reply-To: <Pine.LNX.3.95.1020405161422.1512A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0204060051050.19312-100000@daphnes.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am afraid that is not really necessary(to OR in PAGE_OFFSET) because the
address i get from my code as being the address of IDT is at 0xc3800000,
which seems to be as virtual memory. greetz!

- halfdead

