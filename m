Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVAYEof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVAYEof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVAYEoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:44:34 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:61071 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261804AbVAYEod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:44:33 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Saravanan s <saravanan.mainker@gmail.com>
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.10 
In-reply-to: Your message of "Tue, 25 Jan 2005 09:55:55 +0530."
             <51a933b50501242025645ef27a@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jan 2005 15:44:26 +1100
Message-ID: <15313.1106628266@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 09:55:55 +0530, 
Saravanan s <saravanan.mainker@gmail.com> wrote:
>Hi Keith,
>
>> I have no hardware to test on, so I have
>> to rely on HP to keep the USB patches in KDB up to date. 
>
>Does that mean that there is USB support for KDBv4.4 for kernel 2.6 
>for i386 machines? Or the patch for i386 also comes from the HP guys.

All the USB console patches for kdb came from HP, both i386 and ia64.
Neither work in 2.6 kernels at the moment.

