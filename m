Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTLGToP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTLGToP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:44:15 -0500
Received: from hell.sks3.muni.cz ([147.251.210.31]:60086 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S264499AbTLGToO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:44:14 -0500
Date: Sun, 7 Dec 2003 20:44:04 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Michal Jaegermann <michal@harddata.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics PS/2 driver and 2.6.0-test11
Message-ID: <20031207194404.GC13201@mail.muni.cz>
References: <20031130214612.GP2935@mail.muni.cz> <200311301728.10563.dtor_core@ameritech.net> <20031130223953.GR2935@mail.muni.cz> <200311301826.52978.dtor_core@ameritech.net> <20031130202521.A30370@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031130202521.A30370@mail.harddata.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 08:25:21PM -0700, Michal Jaegermann wrote:
> This particular applet was written by some genius to read a state
> from ACPI _every second_.  To add insult to injury it rereads a
> constant information from ...battery/info on every round instead of
> storing it.  As you can guess it can sink a substantial amount of
> cycles and other resources especially that ACPI in BIOS is also
> often on a very heavy side.

But why it does not hurt with kernel 2.4.22? Moreover how ACPI BIOS influences
synaptics driver? I do not see any BIOS call there...

-- 
Luká¹ Hejtmánek
