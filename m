Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293118AbSBWJZt>; Sat, 23 Feb 2002 04:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293116AbSBWJZb>; Sat, 23 Feb 2002 04:25:31 -0500
Received: from mtao1.east.cox.net ([68.1.17.244]:23784 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP
	id <S293117AbSBWJZN>; Sat, 23 Feb 2002 04:25:13 -0500
Message-ID: <3C775FEF.BDA0253C@randomlogic.com>
Date: Sat, 23 Feb 2002 01:25:03 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Random Logic
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C771D29.942A07C2@starband.net>,
			<3C771D29.942A07C2@starband.net> <20020223134053.4fbe25ed.gang_hu@soul.com.cn> <3C772EF4.DB49876F@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> hugang wrote:
> >
> > On Fri, 22 Feb 2002 23:40:09 -0500
> > Justin Piszcz <war@starband.net> wrote:
> >
> > ...
> > > GCC 2.95.3
> > ...
> > > System is 899 kB
> > ...
> > > GCC 3.0.4
> > ...
> > > System is 962 kB
> > ...
> > >
> > Why the system size is different. Possble your use differ config.
> 

The important thing is:

Which compiler, of all of the different versions, generates the most
stable and fastest code. Compile speed and kernel size is not NEARLY as
important as performance. So, which compiler fits the bill?

PGA
-- 
Paul G. Allen
Owner, Sr. Engineer, Security Specialist
Random Logic/Dream Park
www.randomlogic.com
