Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281595AbRKPWeX>; Fri, 16 Nov 2001 17:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281594AbRKPWeN>; Fri, 16 Nov 2001 17:34:13 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23306 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281592AbRKPWeB>; Fri, 16 Nov 2001 17:34:01 -0500
Subject: Re: Totally Stumped
To: Tony@TRLJC.COM (Tony Reed)
Date: Fri, 16 Nov 2001 22:41:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011116201702.1317C15B48@kubrick.trljc.com> from "Tony Reed" at Nov 16, 2001 03:17:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164rg7-0005Mz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1.0] Won't compile 8139too

Please dont use gcc 3.x to compile kernels

>     (nil)) 8139too.c:2432: Internal compiler error in
>     reload_cse_simplify_operands, at reload1.c:8355 Please submit a full
>     bug report, with preprocessed source if appropriate.  See
>     <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

But do report the data on the compiler failure to the URL above
