Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315570AbSEIAKc>; Wed, 8 May 2002 20:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315571AbSEIAKb>; Wed, 8 May 2002 20:10:31 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59145 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315570AbSEIAKa>;
	Wed, 8 May 2002 20:10:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander.Riesen@synopsys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Wed, 08 May 2002 19:25:57 +0200."
             <20020508172557.GB1044@riesen-pc.gr05.synopsys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 10:10:19 +1000
Message-ID: <13244.1020903019@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 19:25:57 +0200, 
Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>i've found the reason: the make's stdin was redirected in /dev/null
>(my make is aliased to a program prettifying output).

Use standard make.

