Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274809AbRJTHZa>; Sat, 20 Oct 2001 03:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275115AbRJTHZT>; Sat, 20 Oct 2001 03:25:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:29445 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274809AbRJTHZN>;
	Sat, 20 Oct 2001 03:25:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol hotplug_path in usbcore.o as a module (2.4.12) 
In-Reply-To: Your message of "Sat, 20 Oct 2001 08:12:14 +0100."
             <E15uqJ1-0008Mq-01@roo.home> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Oct 2001 17:25:36 +1000
Message-ID: <29038.1003562736@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Oct 2001 08:12:14 +0100, 
Alan Chandler <alan@chandlerfamily.org.uk> wrote:
>alan@kanger:/$ grep hotplug_path /proc/ksyms System.map
>/proc/ksyms:c0290960 hotplug_path_R__ver_hotplug_path

Bingo!  http://www.tux.org/lkml/#s8-8

