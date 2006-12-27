Return-Path: <linux-kernel-owner+w=401wt.eu-S932918AbWL0FvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932918AbWL0FvF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932916AbWL0FvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:51:05 -0500
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:54096
	"EHLO echohome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbWL0FvE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:51:04 -0500
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: "'Tejun Heo'" <htejun@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: System / libata IDE controller woes (long)
Date: Wed, 27 Dec 2006 00:50:57 -0500
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAANz30GbAA9BLm2+8fOoz0KkBAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Thread-Index: AccpaP/mE0iuUFjWQp+QVP+WST45RwAEbsEA
In-Reply-To: <4591EB76.3060801@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi There!
	Yea, I thought that it might be power related as well, so I moved
1/2 of the drives from the 500 Watt power supply onto a separate one, and it
did not change any of the symptoms.  So I think that it's been ruled out.

	Thanks,
		Erik.
> 
> Hello,
> 
> Erik Ohrnberger wrote:
> > Earlier this year, when I started putting it together, I 
> gathered my 
> > hardware.  A decent 2 GHz Athlon system with 512 MB RAM, 
> DVD drive, a 
> > 40 GB system drive, and a 500 Watt power supply.  Then I started 
> > adding hard disks.  To date, I've got 5 80 GB PATA, 2 200 
> GB PATA, and 1 60 GB PATA.
> 
> That's 9 hard drives.  How did you hook up your power supply? 
>  My dual-rail 450w PS has a lot of problem driving 9 drives 
> no matter how I hook it up while my 350w power supply can 
> happily handle the load.  I suspect it's because how the 
> separate 12v rails are configured in the PS.
> 
> It's nothing concrete but I wanna rule PS issue first.  If 
> you've got an extra power supply (buy cheap 350w one if you 
> don't have one), hook half of the drives to it and see what 
> happens.  Using PS without motherboard is easy.  Just ask google.
> 
> Happy holidays.
> 
> --
> tejun
> 

