Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290361AbSBKUuV>; Mon, 11 Feb 2002 15:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290422AbSBKUuL>; Mon, 11 Feb 2002 15:50:11 -0500
Received: from zero.tech9.net ([209.61.188.187]:29700 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290377AbSBKUt7>;
	Mon, 11 Feb 2002 15:49:59 -0500
Subject: Re: thread_info implementation
From: Robert Love <rml@tech9.net>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Arkadiy Chapkis - Arc <achapkis@mail.dls.net>,
        LINUX-KERNEL@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.44.0202112140280.6590-100000@Expansa.sns.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 15:48:54 -0500
Message-Id: <1013460534.6784.477.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 15:42, Luigi Genoni wrote:

> You are optimist.

The glass is always half full ;)

> I could not manage to make my sparc64 boot with 2.5.3+ kernels.
> Now, Actually my problem is reiserFS on sparc64 (I already posted about
> this). Let's hope I could run 2.5 on sparc64 soon ;)

I know Dave Miller merged a lot of SPARC64 code into 2.5.4 (including
preemptible kernel support for SPARC64!) ... at least it compiles.  I
suspect no other arches do right now.

	Robert Love

