Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293531AbSCCJSD>; Sun, 3 Mar 2002 04:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293532AbSCCJRx>; Sun, 3 Mar 2002 04:17:53 -0500
Received: from oe50.law9.hotmail.com ([64.4.8.22]:42758 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S293531AbSCCJRn>;
	Sun, 3 Mar 2002 04:17:43 -0500
X-Originating-IP: [66.108.23.161]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Question on the rmap VM
Date: Sun, 3 Mar 2002 04:17:31 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE50LayI4TY7zD5J47O00005d3d@hotmail.com>
X-OriginalArrivalTime: 03 Mar 2002 09:17:37.0855 (UTC) FILETIME=[4306C4F0:01C1C294]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I have a question on the rmap VM.  What is the swap requierment for it?
I remember the previous Rik van Riel VM required twice the amount of
swapspace as memory to run effectively as many people were complaining about
that.  I read a while ago that the switch in 2.4.10 to the new AA VM fixed
that issue.  Will rmap bring back that 2x requirement?  Thanks.
