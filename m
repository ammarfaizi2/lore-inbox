Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281055AbRKTMiO>; Tue, 20 Nov 2001 07:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281057AbRKTMiF>; Tue, 20 Nov 2001 07:38:05 -0500
Received: from [193.252.19.44] ([193.252.19.44]:63711 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281055AbRKTMh4>; Tue, 20 Nov 2001 07:37:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Robert Love <rml@tech9.net>
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
Date: Tue, 20 Nov 2001 13:37:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Kilobug <kilobug@freesurf.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <E165lQB-0001DZ-00@baldrick> <1006204883.826.0.camel@phantasy>
In-Reply-To: <1006204883.826.0.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166A9X-0000Co-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I find the preemptible kernel patch
very helpful for debugging SMP problems on a
uniprocessor machine.

I'm trying to debug the speedtouch kernel module
crashes with SMP using it: the module oopses
nicely with preempt too!

Duncan. 
