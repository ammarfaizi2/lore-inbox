Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSBORHc>; Fri, 15 Feb 2002 12:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSBORHL>; Fri, 15 Feb 2002 12:07:11 -0500
Received: from [200.180.163.180] ([200.180.163.180]:60508 "EHLO quatroint")
	by vger.kernel.org with ESMTP id <S290215AbSBORHG>;
	Fri, 15 Feb 2002 12:07:06 -0500
Message-ID: <009f01c1b64b$e4b2a580$c50016ac@spps.com.br>
Reply-To: "Fernando Korndorfer" <fernando@quatro.com.br>
From: "Fernando Korndorfer" <fernando@quatro.com.br>
To: "Jorge Nerin" <comandante@zaralinux.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3C66743C.9BA03219@folkwang-hochschule.de> <3C6D34B5.3050900@zaralinux.com>
Subject: Re: funny console prob w/2.4.18-pre[479]+kpreempt+sched-o(1)
Date: Fri, 15 Feb 2002 15:09:19 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

      I'm having the same problems with X. It started 4 months ago, with X
lockups, terminal scrambling and eventual system lockups.
    With krnl 2.4.18-pre8 and XFree 4.2 it is working again (sort of), but
the garbage you mentioned is there. When I come back to console, there are
blinking colored chars on the screen and some times an arrow or an "X" (or
the last  X cursor pointer) that came from X. In my opinion it was a
hardware problem, but for your comments I'm not sure anymore, but I'm sure
it's not a kernel nor XFree issue.
    I have to use a generic svga module, not the proper Savage4. Some
resolutions cause lockups, others don't.



-------------------------------------------------
Fernando Oscar Korndorfer
Suporte - QUATRO Informatica Ltda.
-------------------------------------------------


