Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262873AbRFGTHy>; Thu, 7 Jun 2001 15:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbRFGTHo>; Thu, 7 Jun 2001 15:07:44 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:52213 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S262873AbRFGTHf>; Thu, 7 Jun 2001 15:07:35 -0400
Message-Id: <l0313031cb745811cfc17@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.21.0106061705250.3769-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 7 Jun 2001 20:07:15 +0100
To: Marcelo Tosatti <marcelo@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [PATCH] Reap dead swap cache earlier v2
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>As suggested by Linus, I've cleaned the reapswap code to be contained
>inside an inline function. (yes, the if statement is really ugly)

I can't seem to find the patch which adds this behaviour to the background
scanning.  Can someone point me to it?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


