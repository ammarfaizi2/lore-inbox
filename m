Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbRGTUil>; Fri, 20 Jul 2001 16:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267339AbRGTUiV>; Fri, 20 Jul 2001 16:38:21 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10624 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267338AbRGTUiQ>; Fri, 20 Jul 2001 16:38:16 -0400
Date: Fri, 20 Jul 2001 16:38:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David CM Weber <dweber@backbonesecurity.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Simple LKM & copy_from_user question (followup)
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE00B64A0@bbserver1.backbonesecurity.com>
Message-ID: <Pine.LNX.3.95.1010720163705.7295A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 20 Jul 2001, David CM Weber wrote:

> Attached is the file I"m having problems with.  I'm compiling it w/ 
> 
> gcc -O3 -c main.c
> 
> Thanks in advance,
> 
> 
> Dave Weber
> Backbone Security, Inc.
> 570-422-7900
> 

Top line:

#define __KERNEL__

... compiles without any errors, one warning about an unused variable.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


