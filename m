Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318240AbSIFDQq>; Thu, 5 Sep 2002 23:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSIFDQq>; Thu, 5 Sep 2002 23:16:46 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:17070 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318240AbSIFDQp>;
	Thu, 5 Sep 2002 23:16:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: bert hubert <ahu@ds9a.nl>, Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: side-by-side Re: BYTE Unix Benchmarks Version 3.6
Date: Fri, 6 Sep 2002 05:23:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20020904220055.21349.qmail@linuxmail.org> <20020905134830.GA16149@outpost.ds9a.nl>
In-Reply-To: <20020905134830.GA16149@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n9im-0006Ef-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 15:48, bert hubert wrote:
> Arithmetic Test (type = arithoh)        3598100.4 lps    3435944.6 lps
> Arithmetic Test (type = register)        201521.0 lps     197870.4 lps
> Arithmetic Test (type = short)           190245.9 lps     145140.8 lps
> Arithmetic Test (type = int)             201904.5 lps     104440.5 lps
> Arithmetic Test (type = long)            201906.4 lps     177757.4 lps
> Arithmetic Test (type = float)           210562.7 lps     208476.4 lps
> Arithmetic Test (type = double)          210385.9 lps     208443.3 lps

What kind of arithmetic is this?  Why on earth would arithmetic vary
from one kernel to another?

-- 
Daniel
