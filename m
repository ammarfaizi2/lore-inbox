Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUGHX0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUGHX0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUGHXY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:24:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:33754 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S263088AbUGHXYo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:24:44 -0400
Date: Fri, 9 Jul 2004 01:17:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040709011750.A12605@electric-eye.fr.zoreil.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax> <20040704191732.A20676@electric-eye.fr.zoreil.com> <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com> <20040707005402.A15251@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040707005402.A15251@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Wed, Jul 07, 2004 at 12:54:02AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[...]

Down to 110 ko.

Updated patches are available at
http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm6

It compiles due to cast abuse but I'll have to modify the order to
get the dependencies right.

Dumb question: how should the patches be published once they start to be
ready for wider review ?

--
Ueimor
