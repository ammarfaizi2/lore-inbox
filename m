Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSKYXp7>; Mon, 25 Nov 2002 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSKYXp7>; Mon, 25 Nov 2002 18:45:59 -0500
Received: from dsl-64-34-35-93.telocity.com ([64.34.35.93]:17934 "EHLO
	roo.rogueind.com") by vger.kernel.org with ESMTP id <S264859AbSKYXp6>;
	Mon, 25 Nov 2002 18:45:58 -0500
Date: Mon, 25 Nov 2002 18:53:13 -0500 (EST)
From: Tom Diehl <tdiehl@rogueind.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
In-Reply-To: <13297.1038260058@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0211251848000.8602-100000@tigger.rogueind.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, David Woodhouse wrote:

> 
> pavel@suse.cz said:
> >  I have omnibook xe3, will boot without ACPI but USB will not work due
> > to interrupt routing problems. It has buggy PIR$ table, acpi tables
> > are okay. Of course it is HP bug.
> 
> BIOS authors are universally shite. Film at 11. 
> 
> If it didn't have working ACPI tables either, what would we do? Probably fix
> it with a DMI table entry. This box probably doesn't actually require ACPI
> to boot. 

Is this the same problem that Intel L440GX Motherboards have. In order to get
it to boot I need to compile a custom kernel with acpi enabled. I am told it
is some kind of irq routing problem and only Intel can fix it with a BIOS update
which they do seem interested in addressing. :-( Sure would be nice to be able
to boot stock Red Hat kernels on this machine.

-- 
.............Tom	"Nothing would please me more than being able to 
tdiehl@rogueind.com	hire ten programmers and deluge the hobby market 
			with good software." -- Bill Gates 1976

   			We are still waiting ....

