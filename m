Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUF1OL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUF1OL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 10:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUF1OL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 10:11:58 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:8458 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264962AbUF1OL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 10:11:57 -0400
Date: Mon, 28 Jun 2004 11:01:55 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.7 - 2004-06-27.22.30) - 2 New warnings (gcc 3.2.2)
Message-ID: <20040628140155.GB878@lorien.prodam>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200406281326.i5SDQTCB013940@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406281326.i5SDQTCB013940@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 28, 2004 at 06:26:29AM -0700, John Cherry escreveu:

| drivers/char/ipmi/ipmi_si_intf.c:1174: warning: passing arg 4 of `acpi_install_gpe_handler' from incompatible pointer type
| drivers/char/ipmi/ipmi_si_intf.c:1194: warning: passing arg 3 of `acpi_remove_gpe_handler' from incompatible pointer type
| -

 already fixed in -mm tree. :-)

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
