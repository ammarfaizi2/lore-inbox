Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUAPL0L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 06:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbUAPL0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 06:26:11 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:52164 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S265366AbUAPL0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 06:26:09 -0500
X-Sender-Authentication: net64
Date: Fri, 16 Jan 2004 12:25:50 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: andrew@walrond.org, luming.yu@intel.com, andreas@xss.co.at,
       linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
Message-Id: <20040116122550.23331cf5.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.58L.0401160826090.28357@logos.cnet>
References: <3ACA40606221794F80A5670F0AF15F8401720CA8@PDSMSX403.ccr.corp.intel.com>
	<200401151814.35064.andrew@walrond.org>
	<Pine.LNX.4.58L.0401160826090.28357@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004 08:30:13 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> > I don't know if Stephan filed the report as you requested, but I have tried
> > to independantly confirm this regression on a TR-DLSR server I have here,
> > but unfortunately neither 2.4.23 or 2.4.24 will boot from the Mylex 170
> > Raid card(DAC960) with ACPI enabled, so I never get to lspci :(
> >
> > I could perhaps capture the boot messages over serial port, if that would
> > be helpful?
> 
> Yes, please, with and without ACPI. (I suppose disabling ACPI fixes the
> problem?)
> 
> Stephan: There is nothing from 2.4.23 to .24 which could cause such
> breakage. It probably didnt work with 2.4.23 also?

Hello,

I am sorry for the long delay, I ran completely out of time unfortunately.
In short:
You are right, there is no regression between .23 and .24, shoot me.
Anyway I know there was a former kernel that worked with ACPI on this board.
I wanted to return the info which one though, but don't have it yet.
Anyway as soon as I find some spare time I will go hunting...

Regards,
Stephan
