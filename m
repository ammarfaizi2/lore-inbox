Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264812AbSJVVWE>; Tue, 22 Oct 2002 17:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264769AbSJVVWE>; Tue, 22 Oct 2002 17:22:04 -0400
Received: from email.gcom.com ([206.221.230.194]:8870 "EHLO gcom.com")
	by vger.kernel.org with ESMTP id <S264763AbSJVVWD>;
	Tue, 22 Oct 2002 17:22:03 -0400
Message-Id: <5.1.0.14.2.20021022162535.0274be90@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 22 Oct 2002 16:27:00 -0500
To: Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@redhat.com>
From: David Grothe <dave@gcom.com>
Subject: Re: I386 cli
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021022221923.A2859@mars.ravnborg.org>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost>
 <5.1.0.14.2.20021022145759.02861ec8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Sam.  That's the answer that I was looking for.  Wish I had thought 
to look in the Documentation directory first so as not to have to bother you.
-- Dave

At 10:19 PM 10/22/2002 Tuesday, Sam Ravnborg wrote:

>I would advise you to read: Documentation/cli-sti-removal.txt
>[I recall someone mentioned this documents were slightly out-dated - Ingo?]
>
>The short version is that cli() is no loger valid, drivers using it does 
>not compile.
>
>         Sam

