Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTKFKbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 05:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTKFKbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 05:31:40 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:17037 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263487AbTKFKbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 05:31:39 -0500
Date: Thu, 6 Nov 2003 11:31:37 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: mii broken for 3c59x ?
Message-ID: <20031106103137.GA8800@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0311052142040.19211@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Nov 2003, Maciej Soltysiak wrote:

> I have two 3com 3c905C-TX NICs in my linux box.
> I remember that mii-tool used to work.
> 
> Now, with 2.6.0-test9-bk8 it does not.
> 
> dns:~# mii-tool
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> SIOCGMIIPHY on 'eth1' failed: Operation not supported
> no MII interfaces found
> 
> What might be going on here? Did we have any recent changes in this,
> or maybe my software's outdated, or NICs broken ?

Use mii-diag instead.


-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
