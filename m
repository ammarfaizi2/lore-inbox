Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbRE0QVl>; Sun, 27 May 2001 12:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbRE0QVb>; Sun, 27 May 2001 12:21:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61963 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262799AbRE0QVZ>; Sun, 27 May 2001 12:21:25 -0400
Subject: Re: [PATCH][2.4.5] buz.c compile errors
To: sembera@centrum.cz (Jan Sembera)
Date: Sun, 27 May 2001 17:19:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B111566.6070507@centrum.cz> from "Jan Sembera" at May 27, 2001 01:55:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1543Fv-0001ze-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have written a patch for buz.c for 2.4.5, it should be solution, but i 
> don't know it really works, I don't have such hardware available.

It doesnt work. The entire buz driver is totally broken and to be discarded
