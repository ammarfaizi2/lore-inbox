Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264259AbRFDNmX>; Mon, 4 Jun 2001 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264260AbRFDNmO>; Mon, 4 Jun 2001 09:42:14 -0400
Received: from jalon.able.es ([212.97.163.2]:57305 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264259AbRFDNmE>;
	Mon, 4 Jun 2001 09:42:04 -0400
Date: Mon, 4 Jun 2001 15:41:46 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Pavel Machek <pavel@suse.cz>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: here comes the summer...
Message-ID: <20010604154146.A2155@werewolf.able.es>
In-Reply-To: <20010530233055.A1138@werewolf.able.es> <20010602135800.A33@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010602135800.A33@toy.ucw.cz>; from pavel@suse.cz on Sat, Jun 02, 2001 at 15:58:01 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.02 Pavel Machek wrote:
> Hi!
> 
> > ...again (I think I asked just the same last summer)
> > and lm_sensors is still out of the kernel (we have got 40ºC in Spain
> > this week, and I would like to know how my PIIs suffer...)
> 
> Send some summer over here. It is 15C outside...
> 
> You should try latest ACPI patches, they include thermal managment, too.
> 

I have tried the latest CVS i2c+lm_sensors2, and the patches it generates
look like much more clean. I am waiting for the announced 2.6 relase, and
then will try to send a patch to Alan (if official mantainer do not does it
himself...)

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac6 #2 SMP Sat Jun 2 01:52:13 CEST 2001 i686
