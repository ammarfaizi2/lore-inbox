Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285706AbRLHAZv>; Fri, 7 Dec 2001 19:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285707AbRLHAZn>; Fri, 7 Dec 2001 19:25:43 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12295 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S285706AbRLHAZa>;
	Fri, 7 Dec 2001 19:25:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-ia64@linuxia64.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Linux 2.4.17-pre6 drm-4.0 
In-Reply-To: Your message of "Fri, 07 Dec 2001 15:38:23 -0800."
             <15377.21231.897410.355714@napali.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 11:25:17 +1100
Message-ID: <5103.1007771117@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2001 15:38:23 -0800, 
David Mosberger <davidm@hpl.hp.com> wrote:
>You mean for 2.5?  I don't think there is a good reason to keep
>drm-4.0 there.  For 2.4, we should keep it because there might be
>folks out there that rely on it.

Good.  I will drop drm 4.0 support from kbuild 2.5.

