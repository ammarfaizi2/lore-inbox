Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288932AbSAXTIH>; Thu, 24 Jan 2002 14:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288948AbSAXTH6>; Thu, 24 Jan 2002 14:07:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:56078 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288932AbSAXTHk> convert rfc822-to-8bit;
	Thu, 24 Jan 2002 14:07:40 -0500
Subject: Re: [PATCH] preemptive kernel
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20020124153123Z288377-13996+11264@vger.kernel.org>
In-Reply-To: <20020124153123Z288377-13996+11264@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 14:11:57 -0500
Message-Id: <1011899538.1194.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 10:31, Dieter Nützel wrote:
> Hello Robert,
> 
> can you please redo for O(1)-J6 (2.4.18-pre7) or is nothing changed?

As Ingo and Tom pointed out, its a trivial reject, but I've gone ahead
and updated the 2.4 patches to 2.4.18-pre7 and 2.4.18-pre7-J6:

	ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

My SMP Athlon survived a stress run over night on 2.5.3-pre4-preempt. 
Excellent.

	Robert Love

