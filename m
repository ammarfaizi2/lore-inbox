Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTJ1JRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTJ1JRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:17:11 -0500
Received: from main.gmane.org ([80.91.224.249]:38320 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263893AbTJ1JRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:17:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: SiS900 driver multicast problems and patch.
Date: Tue, 28 Oct 2003 10:17:08 +0100
Message-ID: <yw1xd6ch67sb.fsf@kth.se>
References: <3F9E2B6C.30000@revicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:jQHUvUXtULLMYg5FcyolnTWQ5y4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Knudsen <gandalf@revicon.com> writes:

> After upgrading to kernel 2.4.22 we discovered that multicast was no
> longer handled properly by the SiS900. Examining the changes between
> 2.4.19 and 2.4.22 it is clear that the handling of multicast was
> changed but a bug was introduced.

Your patch is broken.  Long lines are wrapped, tabs are converted to
spaces and it is reversed.

-- 
Måns Rullgård
mru@kth.se

