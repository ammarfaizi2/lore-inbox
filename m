Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUFYOpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUFYOpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 10:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266750AbUFYOpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 10:45:05 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4327 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266748AbUFYOo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 10:44:59 -0400
Message-Id: <200406251444.i5PEiYpq008174@eeyore.valparaiso.cl>
To: "Amit Gud" <gud@eth.net>
cc: "Pavel Machek" <pavel@ucw.cz>, "alan" <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS) 
In-Reply-To: Message from "Amit Gud" <gud@eth.net> 
   of "Fri, 25 Jun 2004 19:32:44 +0530." <004e01c45abd$35f8c0b0$b18309ca@home> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 25 Jun 2004 10:44:34 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amit Gud" <gud@eth.net> said:

[...]

> Also this is applicable to mailboxes - automize the marking of old mails of
> the mailing list as elastic, whenever the threshold is reached, you might
> either want to put those mails as compressed archive or simply delete it.

Right. And which to do is a policy decision, left to the individual owner
of this particular file or collection of files. Democracy at work ;-)

> This has two advantages:
>  - No email bounces for the reason of 'mailbox full' and

It will fill up eventually...

>  - Optimized utlization of the mailbox

> Yes, this can be done using scripts too,

Having the system fool around with my mail because you get too much junk
and can't be bothered to delete it is what I'd consider an hostile act.

Case closed, anyway. It belongs in the kernel only if there is no
reasonable way to do it in userspace.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
