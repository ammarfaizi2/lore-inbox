Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263101AbUEBPpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUEBPpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 11:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUEBPpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 11:45:30 -0400
Received: from web02-imail.bloor.is.net.cable.rogers.com ([66.185.86.76]:9895
	"EHLO web02-imail.rogers.com") by vger.kernel.org with ESMTP
	id S263101AbUEBPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 11:45:28 -0400
Date: Sun, 2 May 2004 11:45:29 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: rol@as2917.net, mbligh@aracnet.com, rusty@rustcorp.com.au, riel@redhat.com,
       nico@cam.org, tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] clarify message and give support contact for non-GPL
 modules
Message-Id: <20040502114529.2dc7940a.seanlkml@rogers.com>
In-Reply-To: <5C616C5C-9C4E-11D8-B83D-000A95BCAC26@linuxant.com>
References: <200405021305.i42D5L625036@tag.witbe.net>
	<5C616C5C-9C4E-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at web02-imail.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sun, 2 May 2004 11:45:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 May 2004 11:35:37 -0400
Marc Boucher <marc@linuxant.com> wrote:

> There will always be things in life that cannot be controlled. The 
> kernel already depends on (by being called by, or itself calling) 
> uncontrolled proprietary code in many environments without telling 
> users about it. Informing people about this is perfectly ok,  
> unnecessarily scaring or confusing them is not.

Agreed.

> Very good point. You can make things as negative-sounding, politically 
> hostile as you want, but Linux distribution vendors would be perfectly 
> free under the GPL to modify the kernel to remove or attenuate 
> exaggerated messages and any other hostile measures if necessary.

Yes.  You're right.

> If the messages are reasonable and clear, no-one will want/try to 
> remove or avoid them, and people will be properly informed.

That is what the latest patch attempts to do while still making sure 
that users are not fooled into thinking they're running an open 
source operating system.

Cheers,
Sean
