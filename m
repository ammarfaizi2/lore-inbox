Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932754AbWHOA13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWHOA13 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 14 Aug 2006 20:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWHOA13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:27:29 -0400
Received: from web54401.mail.yahoo.com ([206.190.49.131]:41646 "HELO
	web54401.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932754AbWHOA12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:27:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QhGrYaG+Up6VWlQtuup7YPT/rFbQvZICdUK6hJBCIheXprxEQGJyOhOmETUzb9ypFE17Z9Om50oyFgfjP2Yvv6HWqDDFUwbm57+qpwHHOCZTXBxYWDmeZuSyCl9FF/W45CIFh1Y6goXWEIp3f/M4bLOrRcm4s8M2VKpXbWN4rMg=  ;
Message-ID: <20060815002727.18956.qmail@web54401.mail.yahoo.com>
Date: Mon, 14 Aug 2006 17:27:24 -0700 (PDT)
From: Eric Radman <ericr2zz@yahoo.com>
Subject: Linux Kernel Developer opening
To: Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62F8B56A.8000908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone seen this listing?

go to www.hotjobs.com and search
on the keyword   51506Linux


--- Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Andrew Morton napisał(a):
> > Please always do reply-to-all.
> > 
> 
> Sorry.
> 
> > 
> > 
> > Could be i8042-get-rid-of-polling-timer-v4.patch. 
> Please try the below
> > reversion patch, on top of rc4-mm1, thanks.
> > 
> > 
> 
> Thanks for help.
> 
> I try this patch, keyboard works, but I have other
> problem. When I try:
> 
> echo "standby" > /sys/power/state
> 
> system goes to standby, but keyboard stop working
> and CMOS clock was
> corrupted (randomize date and time e.g. Fri Feb 18
> 2028 13:57:43). So I
> must reset computer.
> 
> I enclose dmesg with i8042.debug=1 option, config,
> lsmod and fragment of
> syslog, when I tried standby.
> 
> Greetings
> -- 
> Maciej Rutecki <maciej.rutecki@gmail.com>
> http://www.unixy.pl
> LTG - Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/wiki/)
> 

