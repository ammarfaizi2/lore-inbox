Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274029AbRISLM2>; Wed, 19 Sep 2001 07:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273204AbRISLMS>; Wed, 19 Sep 2001 07:12:18 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:50442 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274036AbRISLMJ>;
	Wed, 19 Sep 2001 07:12:09 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Maintaniner on duty <hugh@norma.kjist.ac.kr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre11aa1 compile failure 
In-Reply-To: Your message of "Wed, 19 Sep 2001 17:24:30 +0900."
             <3BA8563E.1050801@norma.kjist.ac.kr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 19 Sep 2001 21:11:20 +1000
Message-ID: <22255.1000897880@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 17:24:30 +0900, 
Maintaniner on duty <hugh@norma.kjist.ac.kr> wrote:
>"make boot" stopped at the last step on UP2000 with two CPU's under SuSE-7.1
>sched.c(.text+0x2680): undefined reference to `touch_nmi_watchdog'

Fixed in 2.4.10-pre12.

