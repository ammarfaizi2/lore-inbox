Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbSLJSqq>; Tue, 10 Dec 2002 13:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265305AbSLJSqp>; Tue, 10 Dec 2002 13:46:45 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:10249 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265270AbSLJSqo>; Tue, 10 Dec 2002 13:46:44 -0500
Subject: Re: How to extract CONFIG file for a kernel
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: SK <linuxkern@yahoo.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210184805.19739.qmail@web14601.mail.yahoo.com>
References: <20021210184805.19739.qmail@web14601.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 10 Dec 2002 13:54:22 -0500
Message-Id: <1039546462.11575.9.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you have RH's /usr/src directory installed, you can cd to
/usr/src/linux-2.4/configs and pick from several pre-built config files.
they work nicely. I use them to build kernel.org kernels. It's *much*
easier to make a few config changes to their config file than starting
from scratch. They tend to be highly modular though... some people don't
like this.

Good luck!

On Tue, 2002-12-10 at 13:48, SK wrote:
> 
> Is there any way to extrace the CONFIG file
> used to compile a kernel. I have 2.4.18-14 kernel
> from RedHat and I want to know the config options
> used for compiling that kernel.
> 
> Any ideas..?
> Thanks
> Santhosh
> 
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Richard B. Tilley (Brad), System Administrator & Web Developer
Virginia Tech, Office of the University Bursar
Phone: 540.231.6277
Fax: 540.231.3238
Page: 557.0891
Web: http://www.bursar.vt.edu

