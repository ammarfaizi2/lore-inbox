Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269599AbRHHXAW>; Wed, 8 Aug 2001 19:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269610AbRHHXAL>; Wed, 8 Aug 2001 19:00:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16655 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269599AbRHHW76>; Wed, 8 Aug 2001 18:59:58 -0400
Subject: Re: 386 boot problems with 2.4.7 and 2.4.7-ac9
To: carljohan@kjellander.com (Carl-Johan Kjellander)
Date: Thu, 9 Aug 2001 00:02:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Carl-Johan Kjellander" at Aug 08, 2001 12:47:57 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UcL5-0006IS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the panic from 2.4.7-ac9 compiled with gcc-2.96-85 (Red Hat).
> 
> ksymoops 2.4.0 on i686 2.4.7.  Options used

Thanks. For some reason it crashed probing the simple boot flag ACPI
structure. I'll try and work out how and why then send you a diff
