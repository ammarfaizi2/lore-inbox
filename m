Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314769AbSDWFZW>; Tue, 23 Apr 2002 01:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314764AbSDWFZU>; Tue, 23 Apr 2002 01:25:20 -0400
Received: from gumby.it.wmich.edu ([141.218.23.21]:35809 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S314734AbSDWFZR>; Tue, 23 Apr 2002 01:25:17 -0400
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam5
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020423002511.GC1693@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 23 Apr 2002 01:25:09 -0400
Message-Id: <1019539515.970.3.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that ide-6 disables Promise ide controllers. Jam2 worked and there
are quite extensive changes to the pdc driver and general ide drivers so
I was unable to eye out what is going wrong.  It doesn't even show up in
lspci.    


Can anyone else verify that this is a general Promise bug in ide-6.  If
not i'll reboot and give an exact list of my card and see if maybe it's
falling through the cracks.  

