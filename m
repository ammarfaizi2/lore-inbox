Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUGEXkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUGEXkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 19:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUGEXkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 19:40:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40885 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262101AbUGEXkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 19:40:04 -0400
Message-ID: <40E9E6BC.8020608@pobox.com>
Date: Mon, 05 Jul 2004 19:39:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: David Gibson <hermes@gibson.dropbear.id.au>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax> <20040704191732.A20676@electric-eye.fr.zoreil.com> <20040706011401.A390@electric-eye.fr.zoreil.com>
In-Reply-To: <20040706011401.A390@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> The news:
> - I got the adequate patch from the cvs repository
> - 35 patches are available at the usual location. The series-mm file
>   describes the ordering of the patches. I'll redo the numbering as
>   it starts to be scary
> - the remaining diff weights ~210k so far
> 
> At least it makes reviewing easier.


If you are willing to do some re-diffing, feel free to send out the 
boring, and easy-to-review parts such as netdev_priv() or obvious 
cleanups.  That would help, at least, to cut things to more meat, and 
less noise.

	Jeff


