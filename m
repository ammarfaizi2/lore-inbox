Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbTAQHgU>; Fri, 17 Jan 2003 02:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbTAQHgU>; Fri, 17 Jan 2003 02:36:20 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:32747 "EHLO
	mailrelay.tugraz.at") by vger.kernel.org with ESMTP
	id <S267418AbTAQHgT>; Fri, 17 Jan 2003 02:36:19 -0500
Message-ID: <1042789515.3e27b48b4462d@webmail.tugraz.at>
X-Priority: 3 (Normal)
Date: Fri, 17 Jan 2003 08:45:15 +0100
From: Maier Gerfried <moali@sbox.tugraz.at>
To: linux-kernel@vger.kernel.org
Subject: Re: Clock does not keep time
References: <1042716941.3e26990dc83b1@webmail.tugraz.at>
In-Reply-To: <1042716941.3e26990dc83b1@webmail.tugraz.at>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 195.49.27.71
X-Oragnization: University of Technology Graz / Austria
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zitat von Maier Gerfried <moali@sbox.tugraz.at>:

> Dear Kernel-List,
> 
> I'm using Linux (kernel 2.4.20 with acpi-20021212 and swsusp-beta16 patches)
> on my Acer Travelmate 630 notebook.
> 
> Unfortunately I experience the problem, that under some [1] conditions the
> RTC does not keep time.

I've done some "research" on this during the night (trying out 2.4.21-pre3 with 
acpi-20030109, but without swsusp), and it seems to me, that a kind of "time-
corruption" occurs on boot. (Looking into the Bios-Setup before the time still 
seems to be ok, but when booting and logging in a time-step has occured) But I 
cannot make a general statement by now.

Any hints are very welcome
Maier Gerfried
-- 

