Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUAJSw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAJSw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:52:26 -0500
Received: from main.gmane.org ([80.91.224.249]:57788 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265296AbUAJSwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:52:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [2.6.1] atkbd.c: Unknown key released
Date: Sat, 10 Jan 2004 19:52:20 +0100
Message-ID: <yw1xlloftz4r.fsf@kth.se>
References: <20040110183116.GA8319@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:J57rRSnrF1UmlOXSpoIJrEw5W84=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudo Thomas <rudo@matfyz.cz> writes:

> Hello.
>
> This line shows up twice in dmesg when starting up X.
>
> atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
>
> Tried with 2.6.1, 2.6.1-mm1. It does not happen in 2.6.0, IIRC. I
> don't seem to be able to reproduce the message by pressing any
> combination on keyboard.

For me, it showed up in 2.6.1-rc1 or possibly -rc2.

-- 
Måns Rullgård
mru@kth.se

