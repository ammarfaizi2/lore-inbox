Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264862AbSKEO2Y>; Tue, 5 Nov 2002 09:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264864AbSKEO2Y>; Tue, 5 Nov 2002 09:28:24 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:58385
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264863AbSKEO2Q>; Tue, 5 Nov 2002 09:28:16 -0500
Date: Tue, 5 Nov 2002 09:32:00 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5] nolapic boot parameter (resend)
In-Reply-To: <Pine.GSO.3.96.1021105125943.18101A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.44.0211050931110.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, Maciej W. Rozycki wrote:

> On Mon, 4 Nov 2002, Zwane Mwaikambo wrote:
> 
> > This has bugged me for a while, also applies to 2.4.45
> 
>  It looks reasonable, but you may consider adding a "lapic" option for
> consistency as well. 

Sure i can do that, i just haven't come across a case where i had to force 
local APIC usage.

	Zwane
-- 
function.linuxpower.ca

