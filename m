Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTHSPxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272064AbTHSPxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:53:53 -0400
Received: from main.gmane.org ([80.91.224.249]:64211 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271368AbTHSPxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:53:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Install new kernel without reboots.
Date: Tue, 19 Aug 2003 17:53:48 +0200
Message-ID: <yw1xr83hlk37.fsf@users.sourceforge.net>
References: <Pine.LNX.4.51.0308191729290.27171@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:cJJ/KE++Zcm55zNMPx56Fw5eQlY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:

> I have heard it is possible to change the kernel without reboots.
> And I am not talking about UML.
>
> Is it true? I could not find any documents on the web.

Maybe your source was referring to modules.  Modules can be replaced
while running, but that's it.  The topic of replacing a running kernel
completely arises a few times a year.  Check the list archive to see
what the problems are.

-- 
Måns Rullgård
mru@users.sf.net

