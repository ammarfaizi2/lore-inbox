Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132169AbRCVUJh>; Thu, 22 Mar 2001 15:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132172AbRCVUJ1>; Thu, 22 Mar 2001 15:09:27 -0500
Received: from monster.amazon.com ([209.191.164.156]:60364 "HELO
	monster.amazon.com") by vger.kernel.org with SMTP
	id <S132169AbRCVUJM>; Thu, 22 Mar 2001 15:09:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Jason T. Murphy" <jtmurphy@amazon.com>
Organization: Amazon.com
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Neal Gieselman <Neal.Gieselman@Visionics.com>
Subject: Re: Where is the RAM?
Date: Thu, 22 Mar 2001 12:05:16 -0800
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D0FA767FA2D5D31194990090279877DA5736B2@dbimail.digitalbiometrics.com> <20010322160607.A9434@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010322160607.A9434@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Message-Id: <0103221205160A.21570@mullen>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 March 2001 07:06 am, Erik Mouw wrote:
> On Thu, Mar 22, 2001 at 08:29:14AM -0600, Neal Gieselman wrote:
> > I have a Redhat 6.1 WS that was installed with 64 MB RAM.  I added
> > another 64 MB, booted, BIOS sees it, but top, free, etc still see only 64
> > MB. Any clues on what to do?
>
> Upgrade to linux-2.2.18 or linux-2.4.2.

Also, some motherboards (Abit BH6's comes to mind) with certain older BIOS 
won't let 2.2.X kernels see all 128 megs. Check your motherboard makers 
website for BIOS update or other like information.

>
>
> Erik

-- 
Jason T. Murphy
System Administrator
Amazon.com
jtmurphy@amazon.com
