Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbTJTRtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 13:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTJTRtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 13:49:22 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:22278 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S262759AbTJTRtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 13:49:08 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <16E52145F803EF44BE0CAB504CEF34E70282A937@ausx2kmpc106.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: sflory@rackable.com, marcelo.tosatti@cyclades.com
cc: Atul.Mukker@lsil.com, linux-kernel@vger.kernel.org
Subject: RE: 2.4.23-pre7 Megaraid2 compile fails
Date: Mon, 20 Oct 2003 12:48:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 138AFF8C446774-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> megaraid2.o megaraid2.c
> megaraid2.c: In function `mega_find_card':
> megaraid2.c:403: structure has no member named `lock'

Get a recent bk snapshot, it's been fixed since -pre7 was released.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

