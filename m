Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTEMOXg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTEMOXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:23:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20123
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261280AbTEMOXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:23:35 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Paul Fulghum <paulkf@microgate.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0305121929300.6225@chaos>
References: <1052775331.1995.49.camel@diemos>
	 <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
	 <20030512233151.B17227@flint.arm.linux.org.uk>
	 <1052781365.1185.5.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.53.0305121929300.6225@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052833031.432.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 14:37:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 00:36, Richard B. Johnson wrote:
> Could somebody please change the error message? Although everybody
> seems to want to be a lawyer, even lawyers don't make law. Certainly
> Software Engineers don't. The correct word is 'invalid', not 'illegal'.
> Yes, I know there is a 30-year history of the use of that word in
> Unix, but it's wrong. Only governments make law.

Much to my suprise you are right on this. The reference dictionary is 
quite explicit that "illegal" means prohibited by law. Since users will
eventually see this message it perhaps does make sense to fix it

