Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275980AbRJPKjF>; Tue, 16 Oct 2001 06:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275981AbRJPKiy>; Tue, 16 Oct 2001 06:38:54 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:13331 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275980AbRJPKih>; Tue, 16 Oct 2001 06:38:37 -0400
Message-ID: <20011016103906.97044.qmail@web11906.mail.yahoo.com>
Date: Tue, 16 Oct 2001 03:39:06 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: Very old kernel.
To: linux-kernel@vger.kernel.org
In-Reply-To: <200110161123.f9GBNXw01262@spnew.snpe.co.yu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Do anybody know how to compile old kernel? (I need
to compile 2.0.35 verion). I make config and make dep,
when I do it I see error (during make dep). I found
this problem as bus error in mkdep binary. I tried to
take config scripts from 2.4.x kernel and it's ok but
when I tried to compile I saw many error connected
with asm statement and function type prefixes (like
__constant_memcopy). I wouldn't like to install old
gcc and old binutils. Are there ways to compile old
kernel with new dev. tools?

Regards,


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
