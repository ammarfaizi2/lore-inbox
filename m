Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTFJAgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 20:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTFJAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 20:36:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23461
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262348AbTFJAgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 20:36:20 -0400
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0306091730310.26529@freak.distro.conectiva>
References: <F760B14C9561B941B89469F59BA3A847E96F25@orsmsx401.jf.intel.com>
	 <Pine.LNX.4.55L.0306091730310.26529@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055206049.31138.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 01:47:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-09 at 21:32, Marcelo Tosatti wrote:
> Just had a few thoughts about that and I want to have a fast 2.4.22
> release (maximum two months). 2.4.21's development time was unnaceptable.
> 
> Lets do the ACPI merge in 2.4.23.

Seems to me the two critical patches for the next 2.4.2x are acpi and the aic7*
stuff, both of which will need a little time but not a lot to bed in

