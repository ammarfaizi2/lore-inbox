Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162053AbWKPRkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162053AbWKPRkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 12:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162057AbWKPRkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 12:40:21 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:39174 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1162053AbWKPRkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 12:40:19 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chris <chris@webteks.co.uk>
Subject: Re: Kernel.org server problems?
Date: Thu, 16 Nov 2006 17:40:35 +0000
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <455C79CE.2010800@webteks.co.uk>
In-Reply-To: <455C79CE.2010800@webteks.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161740.35628.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 14:46, Chris wrote:
> Hi,
>
> Don't know if this is the correct place to bring this up but
> /pub/linux/kernel/* seems to be unavailable on kernel.org via FTP. Both
> my linux box and my work Windows box can connect to kernel.org, but
> cding to the directory (I'm on the Windoze machine at the moment) gives:
>
> 230 Login successful.
> ftp> cd pub
> 250 Directory successfully changed.
> ftp> cd linux
> 250 Directory successfully changed.
> ftp> cd kernel
> 250 Directory successfully changed.
> ftp> cd v2.6
> (after about 30 seconds)
> Connection closed by remote host.
>
> www.kernel.org via http seems to be REALLY slow as well.

Git's also broken. This has become a major problem in recent months..

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
