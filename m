Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTDKPDt (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbTDKPDt (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:03:49 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:54749 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264383AbTDKPDs (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 11:03:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Vikram Rangnekar <vicky@freebsdcluster.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel hcking
Date: Sat, 12 Apr 2003 01:17:10 +1000
User-Agent: KMail/1.5.1
References: <20030411170709.A33459@freebsdcluster.dk>
In-Reply-To: <20030411170709.A33459@freebsdcluster.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120117.10680.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003 01:07, Vikram Rangnekar wrote:
> I'm a kernel newbie and just wanted to know what do most kernel hackers do
> when working on the kernel say 2.5 when you make changes do u need to
> recompile the kernel and reboot the machine to test your small modification
> or do people use something like bochs. Also every time you makes changes in
> the kernel it must be hell to recompile the whole thing do kernel hackers
> just compile the specific file and link it into the kernel or something.
> Some of these will be stupid questions to most of you but I am curious
> since I've been working on the kernel lately and recompiling and rebooting
> is driving me nuts

Try cc cache
http://ccache.samba.org

Con
