Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276929AbRJCJGL>; Wed, 3 Oct 2001 05:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276928AbRJCJGB>; Wed, 3 Oct 2001 05:06:01 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:62646 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S276929AbRJCJFn>; Wed, 3 Oct 2001 05:05:43 -0400
Subject: Re: 2.4.10 hangs on console switch
From: Stephane Dudzinski <stephane@antefacto.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0110022019330.12401-100000@mega.cs.auc.dk>
In-Reply-To: <Pine.GSO.4.33.0110022019330.12401-100000@mega.cs.auc.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 03 Oct 2001 10:02:27 +0100
Message-Id: <1002099747.2190.29.camel@steph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested 2.4.10 since a couple of days, had to reboot my machine
around 10 times since (on a VIA box). It hanged badly a couple of time
with an error message related to : swap, trying to allocate more. Rolled
back to 2.4.9, works fine. 

The intel box on 2.4.10 behaves fine, scary ...

On Tue, 2001-10-02 at 19:21, Lars Christensen wrote:
> > You are using the Nvidia drivers aren't you. They seem to have timing
> > dependant screen mode switch problems. The timing has changed in 2.4.10

-- 
__________________________________________
Stephane Dudzinski   Systems Administrator
a n t e f a c t o     t: +353 1 8586009
www.antefacto.com     f: +353 1 8586014

