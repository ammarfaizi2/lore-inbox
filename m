Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSLJTGK>; Tue, 10 Dec 2002 14:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSLJTGK>; Tue, 10 Dec 2002 14:06:10 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:23791 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261524AbSLJTGJ>; Tue, 10 Dec 2002 14:06:09 -0500
Subject: Re: How to extract CONFIG file for a kernel
From: Arjan van de Ven <arjanv@redhat.com>
To: "Richard B. Tilley   " "(Brad)" <rtilley@vt.edu>
Cc: SK <linuxkern@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1039546462.11575.9.camel@oubop4.bursar.vt.edu>
References: <20021210184805.19739.qmail@web14601.mail.yahoo.com> 
	<1039546462.11575.9.camel@oubop4.bursar.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 20:13:45 +0100
Message-Id: <1039547625.10035.28.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:54, Richard B. Tilley (Brad) wrote:
> If you have RH's /usr/src directory installed, you can cd to
> /usr/src/linux-2.4/configs and pick from several pre-built config files.
> they work nicely. I use them to build kernel.org kernels. It's *much*
> easier to make a few config changes to their config file than starting
> from scratch. They tend to be highly modular though... some people don't
> like this.

in addition there's a copy of the current config as
/boot/config-`uname -r`

