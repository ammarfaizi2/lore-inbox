Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTBCWQ1>; Mon, 3 Feb 2003 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBCWQ1>; Mon, 3 Feb 2003 17:16:27 -0500
Received: from [81.2.122.30] ([81.2.122.30]:5380 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266852AbTBCWQ0>;
	Mon, 3 Feb 2003 17:16:26 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302032226.h13MQZXd000225@darkstar.example.net>
Subject: Re: Help with promise sx6000 card
To: user_linux@citma.cu (Cuenta de la lista de linux)
Date: Mon, 3 Feb 2003 22:26:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030203221923.M79151@webmail.citma.cu> from "Cuenta de la lista de linux" at Feb 03, 2003 05:19:23 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have installed Red Hat 8 with 2.4.18-14 ,i2o support as module, but i can
> not find my card anywhere.
> 
> Here  i am sending you my dmesg and my modules.conf .
> Notes I have a  120GB in hda where i have installed red hat , and 5 hardrives
> in the promise card .
> 
> Why is not my RAID under /dev/i2o/hda ?

I've got a similar bug report to this in my bug database:

http://grabjohn.com/kernelbugdatabase/index.php?action=21&id=33

John.
