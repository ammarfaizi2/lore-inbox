Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbUKBOwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbUKBOwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKBOrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:47:47 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:51371 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261918AbUKBOgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:36:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TmIlMlxFVA9gJDDN5J+eNNovU06ahl+olAF5dV8T0Cgy9nLcZ2YJckEMTm5llBLsvMerutujmfryjHjEcny+CTAJsVQjJqzcTZ+Cv8V+Co/Tx83N1W/nis5hcvq1GZThBgwWcYVBv3eEZglmUoa7vIwtEpVOY87ofZ4KpK+sfF4=
Message-ID: <5d1794bb041102063625a52d93@mail.gmail.com>
Date: Tue, 2 Nov 2004 17:36:54 +0300
From: Vasya Pupkin <ptushnik@gmail.com>
Reply-To: Vasya Pupkin <ptushnik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] comment typo
In-Reply-To: <5d1794bb04103011465b4efd52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5d1794bb04103011465b4efd52@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, guys, Im doing something wrong or it's not typo in comments?


On Sat, 30 Oct 2004 22:46:08 +0400, Vasya Pupkin <ptushnik@gmail.com> wrote:
> Signed-off-by: Vasia Pupkin <ptushnik@gmail.com>
> 
> --- linux-2.6.9/kernel/timer.c.orig     2004-10-30 22:41:14.000000000 +0400
> +++ linux-2.6.9/kernel/timer.c  2004-10-30 22:41:52.000000000 +0400
> @@ -654,7 +654,7 @@
>  /*
>   * The current time
>   * wall_to_monotonic is what we need to add to xtime (or xtime corrected
> - * for sub jiffie times) to get to monotonic time.  Monotonic is pegged at zero
> + * for sub jiffie times) to get to monotonic time.  Monotonic is pegged
>   * at zero at system boot time, so wall_to_monotonic will be negative,
>   * however, we will ALWAYS keep the tv_nsec part positive so we can use
>   * the usual normalization.
>
