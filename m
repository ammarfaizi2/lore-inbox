Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264107AbUDGSLx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbUDGSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:11:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53252 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264107AbUDGSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:11:24 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.5-rc1-tiny1 for small systems
Date: Wed, 7 Apr 2004 21:11:14 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       celinux-dev@tree.celinuxforum.org
References: <20040316222548.GD11010@waste.org> <200404070833.26197.vda@port.imtp.ilyichevsk.odessa.ua> <20040407164035.GT6248@waste.org>
In-Reply-To: <20040407164035.GT6248@waste.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404072109.50466.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Originally I wanted to have CONFIG_MEASURE_INLINES=y,
> > but it died even earlier, looks like my gcc does not like
> > the fact that there is way too many warnings for
> > eisa-bus.c.
>
> Hmm, that's interesting. The measure inlines stuff works by generating
> warnings, but I have yet to see recent GCC quit after too many warnings.

Well, trust me, it really did that. I do not eat magic mushrooms ;)
What gcc do you use? Can you try it with my config?
--
vda

