Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTF3KsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 06:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbTF3KsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 06:48:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:50874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264358AbTF3KsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 06:48:15 -0400
Message-Id: <5.2.0.9.2.20030630125437.00cf7210@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 30 Jun 2003 12:59:18 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <200306302016.21123.kernel@kolivas.org>
References: <5.2.0.9.2.20030630094946.00cfb000@pop.gmx.net>
 <200306291457.40524.kernel@kolivas.org>
 <5.2.0.9.2.20030630094946.00cfb000@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:16 PM 6/30/2003 +1000, Con Kolivas wrote:

>Consider it not optimised yet. The workings are still evolving but are now
>close. It errs on the too-easy to get a bonus in the early ms after an app
>has started at the moment.

Yeah, that's the way it looks from here too.  It's getting it right more 
often than wrong, that's encouraging.

         -Mike 

