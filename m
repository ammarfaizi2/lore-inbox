Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265425AbRF0V4k>; Wed, 27 Jun 2001 17:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbRF0V4a>; Wed, 27 Jun 2001 17:56:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:37642 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265421AbRF0V4T>;
	Wed, 27 Jun 2001 17:56:19 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Manuel A. McLure" <mmt@unify.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Oops at boot with 2.4.5 
In-Reply-To: Your message of "Wed, 27 Jun 2001 13:25:08 MST."
             <419E5D46960FD211A2D5006008CAC79902E5C326@pcmailsrv1.sac.unify.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 07:56:11 +1000
Message-ID: <25660.993678971@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001 13:25:08 -0700, 
"Manuel A. McLure" <mmt@unify.com> wrote:
>When I use an initrd, sometimes when warm-booting I get an "Unable to handle
>kernel NULL pointer dereference"  OOPS just after the "Trying to unmount old
>root ..." message. I ran gdb on vmlinux and got the following stack trace:

Known bug in 2.4.5, fixed in 2.4.6-pre2.


