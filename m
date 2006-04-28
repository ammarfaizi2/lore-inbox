Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWD1GL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWD1GL3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 02:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWD1GL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 02:11:29 -0400
Received: from schihei.net ([81.169.184.117]:14350 "EHLO schihei.org")
	by vger.kernel.org with ESMTP id S1030267AbWD1GL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 02:11:28 -0400
X-PGP-Universal: processed;
	by Achilles.local on Fri, 28 Apr 2006 08:11:25 +0200
In-Reply-To: <1146177388.19236.1.camel@localhost.localdomain>
References: <4450A176.9000008@de.ibm.com> <20060427114355.GB32127@wohnheim.fh-wedel.de> <1146177388.19236.1.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Content-Transfer-Encoding: 7bit
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Date: Fri, 28 Apr 2006 08:11:08 +0200
To: Michael Ellerman <michael@ellerman.id.au>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michael,

On 28.04.2006, at 00:36, Michael Ellerman wrote:

> Try pr_debug() in include/linux/kernel.h

The problem I see with pr_debug() is that it could only activated via
a compile flag. To use the debug outputs you have to re-compile /  
compile
your own kernel.

Regards,
	Heiko


