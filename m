Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSGESeI>; Fri, 5 Jul 2002 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317533AbSGESeH>; Fri, 5 Jul 2002 14:34:07 -0400
Received: from smtp2.wanadoo.nl ([194.134.35.138]:21642 "EHLO smtp2.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S317528AbSGESeG>;
	Fri, 5 Jul 2002 14:34:06 -0400
Message-Id: <5.1.0.14.0.20020705203217.009f5ec0@legolas>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Jul 2002 20:35:52 +0200
To: Mauricio Pretto <pretto@interage.com.br>,
       Lista Kernel <linux-kernel@vger.kernel.org>, hahn@physics.mcmaster.ca
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Subject: Re: 2.5.24 - Swap Problem?
In-Reply-To: <3D25A5BA.7030904@interage.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:57 5-7-02 -0300, Mauricio Pretto wrote:
>I have done this and it steel keep 0 mbs of free Swap used
>like this
>              total       used       free     shared    buffers     cached
>Mem:        182808     178328       4480          0       7544      83744
>-/+ buffers/cache:      87040      95768
>Swap:       136512          0     136512
>Its very strange
>my box almoust hangup

did you see a message like this:
starting swap: swap version 0 is not supported anymore, use mkswap -v1 
/dev/<swapdev>

so could you try to use version 1 swap and see if it still exists

         Rudmer

