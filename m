Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272290AbRHXSdR>; Fri, 24 Aug 2001 14:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272291AbRHXSdH>; Fri, 24 Aug 2001 14:33:07 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:63167
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S272290AbRHXSdA>; Fri, 24 Aug 2001 14:33:00 -0400
Date: Fri, 24 Aug 2001 11:33:17 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Howl of soul...
In-Reply-To: <E15aK0R-000M5f-00@f8.mail.ru>
Message-ID: <Pine.LNX.4.33.0108241122040.11343-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001, Samium Gromoff wrote:

>    If you are to buy a new ide drive, do not buy
>  recent IBM 7200 drives!!!
<snip>
>    Ofcourse he had similar problems.... (btw he use windoze)

This is a known issue that allegedly has nothing to do with the drive, and
everything to do with a bug in many ide controllers.  I have my 307030
running just fine in windows 2k with an intel i815 board.

I *think* the i8xx N/Sbridge chipsets all work fine with the drives.  Mine
do.  A quick search shows complaints with: BX, amd 751, kt 133a, highpoint
chipsets.

Does anyone know what this bug actually is, and whether there's a possible
workaround without disabling udma entirely?


justin

