Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTJaNuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJaNuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:50:55 -0500
Received: from main.gmane.org ([80.91.224.249]:65243 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263282AbTJaNuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:50:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0-test9 vs sound
Date: Fri, 31 Oct 2003 14:50:51 +0100
Message-ID: <yw1x8yn1zfb8.fsf@kth.se>
References: <200310301008.27871.gene.heskett@verizon.net> <200310302049.45009.gene.heskett@verizon.net>
 <yw1xr80tzs0e.fsf@kth.se> <200310310813.02970.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:GKUrVXNcAZgnVEys+dz4Mx97V2E=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

> Some of the tutorials in those links would seem to indicate that 
> /etc/modules.conf has been renamed, which I have not, and my modutils 
> are still the same as I've been using for a few months with 2.4.  I 
> saw an announcement regarding a new modutils tool set last night, do 
> I need to install that, and does that then fubar a 2.4.23-pre8 boot?

You need the new module-init-tools.  If you follow the instructions
provided with them, things will continue to work with 2.4 kernels.

-- 
Måns Rullgård
mru@kth.se

