Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVC1MFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVC1MFR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 07:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVC1MFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 07:05:16 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10447 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261475AbVC1MFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 07:05:09 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
References: <200503280154.j2S1s9e6009981@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 28 Mar 2005 07:04:01 -0500
Message-Id: <1112011441.27381.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 21:54 -0400, Horst von Brand wrote:

> Wrong. You are free to do whatever you like in the privacy of your home,
> but not distribute the result. So you could very well distribute both
> pieces, one under GPL, the other not, and leave the linking to the end
> user.
> 
> Sure, /creating/ the piece to be linked with the GPLed code might make it
> GPL also, but that is another story.

Actually this is an easy one. If you are the creator of the code, you
can license it anyway you want. So you can make it both GPL and allow it
to link with your code. Heck, put it under LGPL since GPL is allowed to
link to that.

Anyway, I don't think that the GPL is that powerful to affect things not
linked directly with it. Just like the MS license can't make you do
certain things that were stated in the license, the GPL can't take too
much control over what you do.  If something in the license is
reasonable, than it is easy to enforce (like taking the code from GPL
source and using it in a binary) but if it starts to stretch (like
controlling the code you write and how you can use it) then that will
have to be fought in court, and will probably lose.

-- Stev


