Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSAIDAW>; Tue, 8 Jan 2002 22:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288745AbSAIDAM>; Tue, 8 Jan 2002 22:00:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36618 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288742AbSAIDAB>; Tue, 8 Jan 2002 22:00:01 -0500
Subject: Re: can we make anonymous memory non-EXECUTABLE?
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 9 Jan 2002 03:11:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a1gar7$12t$1@cesium.transmeta.com> from "H. Peter Anvin" at Jan 08, 2002 06:44:55 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O998-0008Vo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One way to do this would be to create a newbrk() syscall which takes a
> permission argument (for new pages.)

brk(), mmap().

Welcome to libc 8)

