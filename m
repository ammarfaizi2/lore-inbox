Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTEGTyb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264243AbTEGTyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:54:31 -0400
Received: from roc-24-169-2-225.rochester.rr.com ([24.169.2.225]:62115 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP id S264245AbTEGTy1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:54:27 -0400
Date: Wed, 7 May 2003 16:06:51 -0400 (EDT)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Thomas Horsten <thomas@horsten.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include
 support for various K7 optimizations
In-Reply-To: <Pine.LNX.4.40.0305072126450.30616-100000@jehova.dsm.dk>
Message-ID: <Pine.LNX.4.55.0305071605590.709@death>
References: <Pine.LNX.4.40.0305072126450.30616-100000@jehova.dsm.dk>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Thomas Horsten wrote:

> +config K7_ATHLONXP
> +	bool "Athlon XP"
> +	help
> +	  Select this if you have an Athlon XP CPU, to enable optimizations
> +	  specific to that processor.
> +
> +config K7_ATHLONMP
> +	bool "Athlon MP"
> +	help
> +	  Select this if you have an Athlon XP CPU, to enable optimizations
> +	  specific to that processor.

I do believe Athlon XP when you mean MP is a copy/paste typo :)

-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken

