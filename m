Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRLZQzC>; Wed, 26 Dec 2001 11:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282400AbRLZQyw>; Wed, 26 Dec 2001 11:54:52 -0500
Received: from [212.32.196.210] ([212.32.196.210]:54800 "EHLO
	ns.gs7.saminfo.ru") by vger.kernel.org with ESMTP
	id <S281843AbRLZQym>; Wed, 26 Dec 2001 11:54:42 -0500
Message-Id: <200112262055.fBQKtS3F029346@ns.gs7.saminfo.ru>
Date: Wed, 26 Dec 2001 20:55:29 +0400
From: Jelnin Andrey <bsod@gs7.saminfo.ru>
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I have problem with SB-FMI16 radio
In-Reply-To: <Pine.LNX.4.30.0112261147401.20982-100000@rtlab.med.cornell.edu>
In-Reply-To: <200112262042.fBQKgj3F029225@ns.gs7.saminfo.ru>
	<Pine.LNX.4.30.0112261147401.20982-100000@rtlab.med.cornell.edu>
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.10; Linux 2.4.7-ac9; i686)
Organization: JSC Giprosvyaz
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CAC> This is a stupid suggestion, but try running something like aumix or
CAC> something to turn the volume on the output channels on.  For some reason,
CAC> on some soundcards, the driver somehow initializes the board to have 0%
CAC> volume on all output channels!!

I know about it - my first step after trying to control radio - was add mixer settings to maximum and set record on "on-line" chanel 
But, thanx for this suggestion


