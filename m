Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289963AbSAPPsT>; Wed, 16 Jan 2002 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289983AbSAPPsH>; Wed, 16 Jan 2002 10:48:07 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:23558 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S287711AbSAPPr7>; Wed, 16 Jan 2002 10:47:59 -0500
Message-Id: <200201161547.g0GFlfx06709@aslan.scsiguy.com>
To: Richard Harman <rharman@xabean.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.4 "queue abort message" questions 
In-Reply-To: Your message of "Wed, 16 Jan 2002 10:37:24 EST."
             <200201161537.g0GFbOB26942@xabean.xabean.net> 
Date: Wed, 16 Jan 2002 08:47:41 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've got a box that will nolonger boot off it's scsi disk anymore, (but dual b
>ooting to windows works just fine...) did anyone ever get to the bottom of wha
>t caused the "attempting to queue an abort message" bug was?

Those messages don't usually indicate bugs.  Without knowing more about
your system, the devices attached to it, if you happen to have one of
those broken VIA chipsets, etc. its hard to diagnose your problem.

--
Justin
