Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274161AbRJDOj2>; Thu, 4 Oct 2001 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRJDOjT>; Thu, 4 Oct 2001 10:39:19 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:2831 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274161AbRJDOjL>;
	Thu, 4 Oct 2001 10:39:11 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Steve Lord <lord@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2-xfs 
In-Reply-To: Your message of "Thu, 04 Oct 2001 09:01:36 EST."
             <200110041401.f94E1an22571@jen.americas.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 00:39:29 +1000
Message-ID: <31762.1002206369@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Oct 2001 09:01:36 -0500, 
Steve Lord <lord@sgi.com> wrote:
>>  __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9
>Can you map that address onto a symbol by any chance?

ksymoops -A c0127fe9, using ksymoops >= 2.4.3.

