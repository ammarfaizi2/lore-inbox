Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTCETnE>; Wed, 5 Mar 2003 14:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCETnE>; Wed, 5 Mar 2003 14:43:04 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:53189 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261701AbTCETnB>;
	Wed, 5 Mar 2003 14:43:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [BENCHMARK] 2.5.64 with contest
Date: Thu, 6 Mar 2003 06:53:30 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <XFMail.20030305121241.pochini@shiny.it>
In-Reply-To: <XFMail.20030305121241.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303060653.30505.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003 10:12 pm, Giuliano Pochini wrote:
> > ctar_load:
> > Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> > 2.5.64              3   100     79.0    0.0     0.0     1.27
>
> m?  No load ?

Looks like it didn't complete creating a tar in that time or something went 
wrong with the load accounting. The time take for kernel compilation is 
certainly consistent with other kernels.

Con
