Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265922AbUEUQhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUEUQhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUEUQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 12:37:19 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:53151 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265922AbUEUQhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 12:37:18 -0400
Date: Fri, 21 May 2004 18:37:04 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Tim Krieglstein <tstone@fachschaft.informatik.tu-darmstadt.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-xx locks up hard (nforce 2)
Message-ID: <20040521183704.A17758@electric-eye.fr.zoreil.com>
References: <20040517223550.GA7631@host02.fachschaft.informatik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040517223550.GA7631@host02.fachschaft.informatik.tu-darmstadt.de>; from tstone@fachschaft.informatik.tu-darmstadt.de on Tue, May 18, 2004 at 12:35:50AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Krieglstein <tstone@fachschaft.informatik.tu-darmstadt.de> :
[...]
> i forgot...). I know that there are broken out patches available, but
> before starting binary search on the single patches i hope i get an
> educated guess? I have already taken out an rtl8169 network card. But

Please send a message on netdev@oss.sgi.com if it makes a difference.
All known r8169 stability fixes are in 2.6.6.

--
Ueimor
