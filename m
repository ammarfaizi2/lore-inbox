Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSBZO1M>; Tue, 26 Feb 2002 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287631AbSBZO1C>; Tue, 26 Feb 2002 09:27:02 -0500
Received: from [212.3.242.3] ([212.3.242.3]:11016 "HELO mail.i4gate.net")
	by vger.kernel.org with SMTP id <S287596AbSBZO0w>;
	Tue, 26 Feb 2002 09:26:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Guido Volpi <lugburz@tiscalinet.it>
Subject: Re: oproblem with nvidia driver
Date: Tue, 26 Feb 2002 15:27:07 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
In-Reply-To: <200202261447.g1QElLO02468@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020226142659Z287596-889+7278@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 February 2002 15:47, Guido Volpi wrote:
> it's all right: nvidia modules depend only by nvidia, but i don't
> understand why a module that is perfect (or so) with 2.4.17 in 2.4.18-rc4
> is no more usabily.

The correct thing to to is to complain to NVidia about this. They created a 
closed source driver - so this is their problem.

Optionally, you could check the #nvidia channel on irc.openprojects.net for a 
quick hack (or hack it yourself).

DK
