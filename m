Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287299AbSALXCk>; Sat, 12 Jan 2002 18:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287630AbSALXCW>; Sat, 12 Jan 2002 18:02:22 -0500
Received: from camus.xss.co.at ([194.152.162.19]:18442 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S287299AbSALXCB>;
	Sat, 12 Jan 2002 18:02:01 -0500
Message-ID: <3C40C066.CF147D02@xss.co.at>
Date: Sun, 13 Jan 2002 00:01:58 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
In-Reply-To: <3C40B268.C2B87902@xss.co.at> <20020112173430.A31913@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Sat, Jan 12, 2002 at 11:02:16PM +0100, Andreas Haumer wrote:
> > Hi!
> >
> > I'm seeing a problem with SMP Linux-2.2.20 on an ASUS CUR-DLS
> > motherboard. I noticed there were similar reports in the
> > past few months and I got the impression the problem should
> > already be fixed in 2.2.20, but seemingly it isn't.
> 
> This bug is fixed in 2.4.
> 
Aha!

Anyone working on backporting it to 2.2.21? 
Alan?

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
