Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276883AbRJHN0R>; Mon, 8 Oct 2001 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276888AbRJHN0H>; Mon, 8 Oct 2001 09:26:07 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:47367 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276883AbRJHNZx>;
	Mon, 8 Oct 2001 09:25:53 -0400
Date: Mon, 8 Oct 2001 15:25:44 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux should not set the "PnP OS" boot flag
Message-ID: <20011008152542.J12242@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <1002544823.953.16.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1002544823.953.16.camel@thanatos>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 08:40:21AM -0400, Thomas Hood wrote:

> I have a suspicion that those Phoenix BIOSes that oops when
> "current" configuration is accessed are oopsing because
> the BIOS hasn't initialized the "current" configuration ...
> because the PnP-OS bit is set.  I've asked Stelian to test
> this hypothesis; no word back yet.

Sorry, the weekend is too short sometimes...

Anyway, the PnP OS setting in the BIOS doesn't change anything
regarding to the Linux PnP initialisation oops (same printouts,
same calltrace, etc).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
