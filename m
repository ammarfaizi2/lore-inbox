Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288930AbSAXXOn>; Thu, 24 Jan 2002 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290457AbSAXXOd>; Thu, 24 Jan 2002 18:14:33 -0500
Received: from dpc6682034030.direcpc.com ([66.82.34.30]:260 "EHLO
	oscar.hatestheinter.net") by vger.kernel.org with ESMTP
	id <S288930AbSAXXOZ>; Thu, 24 Jan 2002 18:14:25 -0500
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
From: Disconnect <lkml@sigkill.net>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201242240380.9957-100000@infcip10.uni-trier.de>
In-Reply-To: <Pine.LNX.4.40.0201242240380.9957-100000@infcip10.uni-trier.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 24 Jan 2002 18:11:06 -0500
Message-Id: <1011913866.2189.15.camel@oscar>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-24 at 16:44, Daniel Nofftz wrote:
> but : cause i have no problems with the patch, i have another problem : i
> could not look where the problems come from ... :( ... so i need those on
> of you, who have problems with it, so we could track the cause of the
> problems down ...

Lemme know what you need.

> > Also, I noticed an odd problem w/ ACPI. dmesg shows:
> > ACPI: Power Button (FF) found
> > ACPI: Multiple power buttons detected, ignoring fixed-feature
> > ACPI: Power Button (CM) found
> 
> as far as i know the power button does not work at all with the curent
> kernel ... so i think it is no problem :)

I just apt-get install acpid and edit /etc/acpi/default.sh to do
whatever I want :)


