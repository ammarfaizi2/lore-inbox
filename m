Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVGKUUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVGKUUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 16:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVGKUSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 16:18:53 -0400
Received: from web32415.mail.mud.yahoo.com ([68.142.207.208]:59479 "HELO
	web32415.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262567AbVGKUQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 16:16:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1rUUxtIzS25ujzE1OEeLTCSNLgmql7QCbdVkHCxOqfKWWqCpynAnP0P8oWB2MhBKiO9GO92+9Jn8wgSWdqT1g1PJV9xwycAB57dd0YqI5gVhXnoolX4k4BXBJRzf2+4iNCcJAWNA2EXmQ6mQhu9IgHuLDIh+kTE3YN1VSjHa7dc=  ;
Message-ID: <20050711201650.25750.qmail@web32415.mail.mud.yahoo.com>
Date: Mon, 11 Jul 2005 13:16:50 -0700 (PDT)
From: Anil kumar <anils_r@yahoo.com>
Subject: noapic for smp
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a rhel4 (2.6.9-5.EL) system. 
The SMP kernel boot fails(rather locks up system). But
when use "noapic" it boots fine.

Is it that my system "APIC" is bad?

Will "noapic" have performance impact (IRQ
routing,etc)? 
My system is a Uni processor with HT enabled.

with regards,
   Anil


		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

