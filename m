Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUBAVBW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265452AbUBAVBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:01:19 -0500
Received: from main.gmane.org ([80.91.224.249]:53384 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265464AbUBAVAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:00:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ifconfig question
Date: Sun, 01 Feb 2004 21:54:40 +0100
Message-ID: <yw1xd68yplkf.fsf@kth.se>
References: <Pine.LNX.4.44.0402012241430.6206-100000@midi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti200710a080-2939.bb.online.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:+jag+F5fLWK3wupgbC/iIBVZ2XA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka <midian@ihme.org> writes:

> Hi again list,
> I have another question too, this is about the ifconfig bit counter.
> Myself I use a patch for it to not restart at 4GB (?).
> is it meant to restart at that position or don't anyone care to expand the
> limit to some higher values?

FWIW, the limit is much higher on 64-bit systems.

-- 
Måns Rullgård
mru@kth.se

