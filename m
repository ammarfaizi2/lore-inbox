Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263028AbTCLEga>; Tue, 11 Mar 2003 23:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263030AbTCLEg3>; Tue, 11 Mar 2003 23:36:29 -0500
Received: from pop.gmx.de ([213.165.64.20]:57882 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263028AbTCLEg3>;
	Tue, 11 Mar 2003 23:36:29 -0500
Message-Id: <5.2.0.9.2.20030312051308.00c985c0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 12 Mar 2003 05:51:46 +0100
To: jim.houston@attbi.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] self tuning scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E6E6B81.4E7CD256@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:04 PM 3/11/2003 -0500, Jim Houston wrote:
>I'm still playing with the "make -j 30".

Just a note:  if you play with it in a ram poor environment like mine, you 
may need to adjust the number of tasks considerably... gcc > 2.95.x makes 
size "Godzilla" footprints.

         -Mike 

