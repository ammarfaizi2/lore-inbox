Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271851AbRICWvR>; Mon, 3 Sep 2001 18:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271849AbRICWvI>; Mon, 3 Sep 2001 18:51:08 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:829 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S271848AbRICWuu>; Mon, 3 Sep 2001 18:50:50 -0400
Subject: Re: Sound Blaster Live - OSS or Not?
From: Robert Love <rml@tech9.net>
To: Thiago Vinhas de Moraes <tvlists@networx.com.br>
Cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200109032224.f83MOqj17675@jupter.networx.com.br>
In-Reply-To: <01090310483100.26387@faldara>
	<200109032210.f83MA8j15720@jupter.networx.com.br>
	<15e28I-09mKq8C@fmrl04.sul.t-online.com> 
	<200109032224.f83MOqj17675@jupter.networx.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 03 Sep 2001 18:51:09 -0400
Message-Id: <999557473.7696.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-09-03 at 18:26, Thiago Vinhas de Moraes wrote:
> > Use the alsa driver from www.alsa-project.org
> Why isn't it on the kernel tree?

Because ALSA is not in the kernel tree. ALSA is a completely different
sound system from OSS, and ALSA is not in the tree. Many find ALSA
superior, and suggest it replace OSS. ALSA may find its way into the
tree during 2.5.

Of note, I don't know why SBLive does not work w/o these drivers. SBLive
in the kernel tree is very functional, and the OSS version should work
fine (assuming the game works with OSS).

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

