Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbTHZFuB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTHZFuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:50:00 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:27029 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262612AbTHZFt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:49:59 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Ramdisk memory usage
Date: Tue, 26 Aug 2003 02:50:01 -0300
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.33.0308261222380.12086-100000@alpha.cpe.ku.ac.th>
In-Reply-To: <Pine.LNX.4.33.0308261222380.12086-100000@alpha.cpe.ku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308260250.01499.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 02:26, Theewara Vorakosit wrote:
> Dear All,
> 	I use redhat linux 9 with kernel 2.4.20-20.9. Linux supports 16
> ramdisks with size of 4MB. So, all memory needed are 64MB. I want to know
> that memory space for ram disk is allocated at boot time or when I really
> use it?
> Thanks,
> Theewara

It's dynamically allocated.

Lucas
