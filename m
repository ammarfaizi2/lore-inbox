Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSJWCUx>; Tue, 22 Oct 2002 22:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbSJWCUw>; Tue, 22 Oct 2002 22:20:52 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:61656 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S262730AbSJWCUw>; Tue, 22 Oct 2002 22:20:52 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DF61@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Thomas Molina'" <tmolina@cox.net>, linux-kernel@vger.kernel.org
Cc: "'dahlm@izno.net'" <dahlm@izno.net>
Subject: RE: 2.5 Problem Report Status
Date: Tue, 22 Oct 2002 19:26:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Thomas Molina [mailto:tmolina@cox.net] 

>    open                   07 Oct 2002 illegal sleeping 
> function called 
>                                       from acpi_os_wait_semaphore()
>   10. 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103404677824885&w=2

Fixed.

(the other 3 ACPI bugs are still open)

Regards -- Andy
