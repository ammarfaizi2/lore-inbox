Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSEYTel>; Sat, 25 May 2002 15:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSEYTek>; Sat, 25 May 2002 15:34:40 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:62037 "EHLO
	tsmtp9.mail.isp") by vger.kernel.org with ESMTP id <S315265AbSEYTek>;
	Sat, 25 May 2002 15:34:40 -0400
Date: Sat, 25 May 2002 21:34:40 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, pavel@ucw.cz
Subject: Re: 2.5.18, pdflush 100% cpu utilization
Message-Id: <20020525213440.32860d08.DiegoCG@teleline.es>
In-Reply-To: <20020525212512.7a14d1d9.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002 21:25:11 +0200
Diego Calleja <DiegoCG@teleline.es> escribió:

I've forgiven to say that I added 
#include <linux/buffer_head.h>
(as posted in lkml)

to get Software suspend to compile ;)


Diego Calleja
