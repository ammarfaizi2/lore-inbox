Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280391AbRJaSbc>; Wed, 31 Oct 2001 13:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280392AbRJaSbX>; Wed, 31 Oct 2001 13:31:23 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:34703 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S280391AbRJaSbK>; Wed, 31 Oct 2001 13:31:10 -0500
Message-Id: <200110311831.f9VIVeR09294@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: LLX <llx@swissonline.ch>
Reply-To: llx@swissonline.ch
To: Rik van Riel <riel@conectiva.com.br>, Timur Tabi <ttabi@interactivesi.com>
Subject: Re: Module Licensing?
Date: Wed, 31 Oct 2001 19:31:40 +0100
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0110311535250.2963-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0110311535250.2963-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The irrelevance here is IYHO ... it may well be judged that
> since these two portions of the work need each other in order
> to function, the thing really is one work.

a)
vmware for linux needs a linux kernel to work. does that meen
you whant to gpl it? 

b)
you can write abstraction modules for different os's. and the 
non-gpl module works with all of them. so my module does not
need the linux abstraction module it also works with the free-
BSD module. the only #ifdef in my module will be around the 
module registration code. or i write a propriatary loader,
so that even the same binary works for different os's



-- 
****** It's nice to be important, but it's more important to be nice ! ******
