Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLZVy7>; Thu, 26 Dec 2002 16:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSLZVy7>; Thu, 26 Dec 2002 16:54:59 -0500
Received: from smtp.terra.es ([213.4.129.129]:2353 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id <S264631AbSLZVy7>;
	Thu, 26 Dec 2002 16:54:59 -0500
Date: Thu, 26 Dec 2002 23:03:04 +0100
From: Arador <diegocg@teleline.es>
To: Ro0tSiEgE <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debian boot-flopppies and 2.5.53 dont mix
Message-Id: <20021226230304.10c557c4.diegocg@teleline.es>
In-Reply-To: <200212261538.59540.lkml@ro0tsiege.org>
References: <200212261538.59540.lkml@ro0tsiege.org>
X-Mailer: Sylpheed version 0.8.7 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Dec 2002 15:38:59 -0600
Ro0tSiEgE <lkml@ro0tsiege.org> wrote:

> I've tried 5 different IRC channels and no one will give me any answers. I 
> created a Debian (woody) install cd for my laptop (no floppy) and the kernel 
> 2.5.53 (2.4 and below have VERY weird issues with my pavilion notebook and 
> the ALi chipset, which still no one can give an answer as to how to fix 
> THAT), and it panics saying Unable to mount root "" or 01:00. Some people 

well, 2.5 is called "unstable" for something :)
try 2.4.21-pre2 that has some ide updates (from 2.4 -ac, which you could try, too)
If all that doesn't works (and you're sure that's a kernel fault), try to do
a full-featured bug report, and be sure that then, people will listen you.
