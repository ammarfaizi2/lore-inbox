Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbTEKWom (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbTEKWom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:44:42 -0400
Received: from mail.webmaster.com ([216.152.64.131]:63740 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261374AbTEKWok
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:44:40 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: The disappearing sys_call_table export.
Date: Sun, 11 May 2003 15:57:21 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEFFCOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1052689591.30506.9.camel@dhcp22.swansea.linux.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Security requirements are heavily dependant on role and people sometimes
> forget that. Being down is bad news for an ecommerce site but in many
> other situations its infinite preferably to most other situations

	This reminds me of a funny story. I was at a meeting to confirm that a
program met some requirements for an agency in Maryland with a three-letter
name. After they finally agreed that I had to *see* the requirements before
I could assert that the program met them, we came to a requirement that
said, roughly, that it must be possible to immediately stop the system from
processing any information if they lost, or suspected that they had lost,
control over it.

	I pointed out to them that any software mechanism I devised for shutting
the system down would require that they had control over the system in order
to invoke the mechanism.

	They thought about that for a moment and were about to find that the system
did not meet the requirements. I pointed out that anyone could pull the plug
or network cable if needed or shut the system down at the switch and that
this could be accomplished even if they lost control over the system and
would certainly stop it from sending any information. They then agreed that
the system met that requirement.

	DS


