Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290634AbSARIFy>; Fri, 18 Jan 2002 03:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290633AbSARIFo>; Fri, 18 Jan 2002 03:05:44 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:50440 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290632AbSARIFh>;
	Fri, 18 Jan 2002 03:05:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: benc@hawaga.org.uk, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPs reading audio data from CD, ide-cd. 
In-Reply-To: Your message of "Fri, 18 Jan 2002 09:57:37 +0200."
             <Pine.LNX.4.44.0201180955520.29505-100000@netfinity.realnet.co.sz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Jan 2002 19:05:24 +1100
Message-ID: <9550.1011341124@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002 09:57:37 +0200 (SAST), 
Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
>Which kernel version? And could you manually run a ksymoops on the *first* 
>oops you receive, avoiding rebooting if possible.

Or use /var/log/ksymoops.  man insmod, look for ksymoops assistance.

