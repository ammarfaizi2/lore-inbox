Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbQKSQI6>; Sun, 19 Nov 2000 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbQKSQIr>; Sun, 19 Nov 2000 11:08:47 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:15861 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S132418AbQKSQIf>; Sun, 19 Nov 2000 11:08:35 -0500
Message-ID: <3A17F3F8.C6A8E6B9@haque.net>
Date: Sun, 19 Nov 2000 10:38:32 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gianluca Anzolin <g.anzolin@inwind.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: XMMS not working on 2.4.0-test11-pre7
In-Reply-To: <20001119150645.A732@fourier.home.intranet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's working fine here w/o modification. Maybe you need the latest
version or have somethinn enabled that I don't.

Gianluca Anzolin wrote:
> 
> it seems there has been a change in the format of the /proc/cpuinfo file: infact 'flags: ' became 'features: '
> 
> This change broke xmms and could broke any other program which relies on /proc/cpuinfo...
> 
> I hope the problem will be solved (in the kernel or in every other program which uses /proc/cpuinfo) soon...
> 
> Bye
>         Gianluca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
