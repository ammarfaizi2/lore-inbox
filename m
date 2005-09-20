Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVITHLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVITHLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbVITHLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:11:17 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:39274 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932536AbVITHLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:11:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KFGprvVndVOY1/fOhY/8HVyuJQQjkC5Tg87nrYUoWaXRsGL418aoqZ9LS690eA/OBFOk0FrTlFyOvjiubYKVO9k6c5zPfzn/CqbOXEUETggEk8tMgxnKePhdljV4pjuV6M2wTKVpnCMHXyL6/6WVcHROrgz8fyAlFFecB8+qpks=
Message-ID: <1e62d13705092000112a49cb6c@mail.gmail.com>
Date: Tue, 20 Sep 2005 12:11:15 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: fawadlateef@gmail.com
To: Gireesh Kumar <gireesh.kumar@einfochips.com>
Subject: Re: regarding kernel compilation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Gireesh Kumar <gireesh.kumar@einfochips.com> wrote:
> Hi,
> I'd like to compile 2.4.20-6 kernel while running in 2.6 kernel. I tried
> to do so but there are redeclaration errors with /kernel/sched.c and
> /include/linux/sched.h. One it is FASTCALL and the other it is not.
> Can anyone help me to fix this?

I don't think you will be able to compile 2.4 kernel on to the 2.6
kernel based distro .... as in 2.6 based distro, mod-utils and other
packages are updated and will only support 2.6 based kernel .... So
its better to get 2.4 kernel based distribution .... (and can keep/run
both 2.6 and 2.4 based distributions simultanously on the same system,
so that you can boot in any of them as per your requirement of 2.4 or
2.6 kernel)

-- 
Fawad Lateef
