Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264193AbUEDBfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbUEDBfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbUEDBfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:35:07 -0400
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:22754 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S264193AbUEDBfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:35:04 -0400
Date: Tue, 4 May 2004 03:35:36 +0200
From: Frank v Waveren <fvw@var.cx>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Filesystem with multiple mount-points
Message-ID: <20040504013536.GA4294@var.cx>
References: <Pine.LNX.4.44.0405021951100.2613-100000@poirot.grange> <200405030110.00102.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405030110.00102.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:10:00AM +0300, Denis Vlasenko wrote:
> You haven't symlinked /etc/mtab to /proc/mounts.
> I always do it. Kernel knows better what is mounted, and where.
It has it's charms, but you enter big-problem country once you start
doing stuff like mount -o loop.

-- 
Frank v Waveren                                      Fingerprint: 9106 FD0D
fvw@[var.cx|stack.nl] ICQ#10074100                      D6D9 3E7D FAF0 92D1
Public key: hkp://wwwkeys.pgp.net/8D54EB90              3931 90D6 8D54 EB90
