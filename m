Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWDCMKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWDCMKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDCMKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:10:14 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:54956 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S1750710AbWDCMKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:10:13 -0400
From: Francesco Biscani <biscani@pd.astro.it>
To: "Maurizio Lombardi" <m.lombardi85@gmail.com>
Subject: Re: ACPI Error (Method parse/execution failed) with 2.6.16 kernel
Date: Mon, 3 Apr 2006 14:09:46 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <c87e555d0603311120n52e78493u610de7a8474e65d3@mail.gmail.com>
In-Reply-To: <c87e555d0603311120n52e78493u610de7a8474e65d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604031409.47274.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 21:20, Maurizio Lombardi wrote:
> Hi,
>
> I had some problems switching from 2.6.15.6 to 2.6.16 kernel version.
> At boot sometimes i get some errors about ACPI, you can find logs as
> attachment. As a result, sometimes my laptop is unable to read battery
> remaining capacity level.
>
> Do you know how to fix this problem?

FYI I had ACPI-related issues too when upgrading to 2.6.16 from 2.6.15. Your 
error messages seem similar to mine, for which I've opened a bugreport here

http://bugzilla.kernel.org/show_bug.cgi?id=6278

Maybe together we can make some more noise ;)

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
