Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRHGPAK>; Tue, 7 Aug 2001 11:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267987AbRHGO77>; Tue, 7 Aug 2001 10:59:59 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:11020 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S266673AbRHGO7l>; Tue, 7 Aug 2001 10:59:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: tulip driver problem
In-Reply-To: <9kogt9$l12$1@ns1.clouddancer.com>
In-Reply-To: <20010806100319.C833@cpe-24-221-152-185.az.sprintbbd.net>    <200108062016.f76KGmG117015@saturn.cs.uml.edu> <20010807124413.A14235@lech.pse.pl> <200108062016.f76KGmG117015@saturn.cs.uml.edu> <9kogt9$l12$1@ns1.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20010807145951.71904784C1@mail.clouddancer.com>
Date: Tue,  7 Aug 2001 07:59:51 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>Does eth0 share IRQ with any other card? I got the very same messages
>when one of my 4-way Adaptec (tulip based) ports got assigned the same
>IRQ as my SCSI card (53c810a). BTW, that forced me to swich to using
>de4x5 driver...
>-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --



Goto Becker's website and fetch the IRQ sharing info, then patch the
scsi driver.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

