Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJVRLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJVRLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271452AbUJVRCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:02:25 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56586 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S271451AbUJVQ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:57:15 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: cijoml@volny.cz
Subject: Re: Hibernation and time and dhcp
Date: Fri, 22 Oct 2004 19:56:58 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410202045.24388.cijoml@volny.cz> <200410211531.50238.vda@port.imtp.ilyichevsk.odessa.ua> <200410220113.16593.cijoml@volny.cz>
In-Reply-To: <200410220113.16593.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410221956.59112.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 October 2004 02:13, Michal Semler wrote:

> > These should be handled in userspace. You can put together
> > some simple shell script to do it with (hwclock or ntpdate) and [u]dhcp*
> 
> Yes, it's possible, but many programs crashes when time is moved about hours 
> or days. And till time they will be repaired, we should ask for time BIOS to 
> have little time difference.

Those programs are buggy.
--
vda

