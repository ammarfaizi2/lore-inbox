Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTBQNss>; Mon, 17 Feb 2003 08:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbTBQNsr>; Mon, 17 Feb 2003 08:48:47 -0500
Received: from [207.61.129.108] ([207.61.129.108]:41186 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S267079AbTBQNra>; Mon, 17 Feb 2003 08:47:30 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.5.60/61] - Making modules problem
Date: Mon, 17 Feb 2003 08:58:42 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302170858.42376.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this, I didn't realize that you have to make the kernel image first 
THEN compile modules, before it would allow building modules before an actual 
kernel was compiled :-)

Shawn.

>List:     linux-kernel
>Subject:  [BUG][2.5.60/61] - Making modules problem
From:     Shawn Starr <spstarr () sh0n ! net>
>Date:     2003-02-16 5:11:05

>when doing make modules it does not build modules? It builds the kernel 

>Has this behaviour changed or is this broken right now?

>Shawn.

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

