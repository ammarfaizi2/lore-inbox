Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLPH20>; Sat, 16 Dec 2000 02:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLPH2R>; Sat, 16 Dec 2000 02:28:17 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:60935 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129183AbQLPH2D>;
	Sat, 16 Dec 2000 02:28:03 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: ferret@phonewave.net
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux 
In-Reply-To: Your message of "Fri, 15 Dec 2000 19:37:49 -0800."
             <Pine.LNX.3.96.1001215193529.19208C-100000@tarot.mentasm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 17:57:31 +1100
Message-ID: <13385.976949851@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2000 19:37:49 -0800 (PST), 
ferret@phonewave.net wrote:
>Do you have an alternative reccomendation? I've shown where the symlink
>method WILL fail. You disagree that having the configured headers copied
>is a workable idea. What else is there?

Use the pcmcia-cs method.  Ask where the kernel headers with a sensible
default if the user just presses <ENTER>.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
