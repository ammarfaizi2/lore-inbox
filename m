Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293487AbSCGLMD>; Thu, 7 Mar 2002 06:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293508AbSCGLLx>; Thu, 7 Mar 2002 06:11:53 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:47121 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S293487AbSCGLLp>; Thu, 7 Mar 2002 06:11:45 -0500
Message-ID: <3C874AE8.9060208@linkvest.com>
Date: Thu, 07 Mar 2002 12:11:36 +0100
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <E16ik6y-0008Qf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2002 11:11:36.0598 (UTC) FILETIME=[D8E32360:01C1C5C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>
>Any reason for preferring this over the sard patches in -ac ?
>
What does the sard patches?
What I need is to be able to get IO stats to pass them (through a home 
made script) to SNMP which have no IO stats available.
Is it possible to get SARD values through /proc ? Or at least in a 
simple shell script?
Thanks
-jec

-- 
Jean-Eric Cuendet
Linkvest SA
Av des Baumettes 19, 1020 Renens Switzerland
Tel +41 21 632 9043  Fax +41 21 632 9090
E-mail: jean-eric.cuendet@linkvest.com
http://www.linkvest.com
--------------------------------------------------------



