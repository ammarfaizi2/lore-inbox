Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288471AbSADLju>; Fri, 4 Jan 2002 06:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288603AbSADLjk>; Fri, 4 Jan 2002 06:39:40 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:46608 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S288481AbSADLjb>; Fri, 4 Jan 2002 06:39:31 -0500
Message-ID: <3C3592E0.38DFA96A@sirius-cafe.de>
Date: Fri, 04 Jan 2002 12:32:48 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davej@suse.de
Subject: Hardware Inventory [was: Re: ISA slot detection on PCI systems?]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones (davej@suse.de)
> Date: Wed Jan 02 2002 - 18:31:33 EST
> 
> 
> On Wed, 2 Jan 2002, Alan Cox wrote:
> 
> > > What's wrong with a startup routine that includes something like:
> > > dmidecode > /var/run/dmi
> > Absolutely nothing, and that also handily means it isnt setuid 8)
> 
> Indeed, it's perfect. Except no distro does it (yet), but it's
> definitly the best idea so far in this thread.
> 

 seeing this thread - is there any serious work being spend on something
like "hinv" on IRIX, which gives you a *complete* listing of your
hardware? I have seen some attempts at shell and perl scripts, but none
of them really is trustworthy.

Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
