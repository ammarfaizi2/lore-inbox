Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUGMQwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUGMQwy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265515AbUGMQwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:52:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:54027 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265509AbUGMQwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:52:50 -0400
Date: Tue, 13 Jul 2004 18:29:27 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: Jeff Garzik <jgarzik@pobox.com>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: SATA disk device naming ?
In-Reply-To: <20040713164911.GA947@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0407131828450.30340-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jul 2004, Jeff Garzik wrote:
> For LABEL to work on root filesystem, you need an initrd.

Ok, now I know why it doesn't work for me --- I always disable initrd
after fresh installation. Thank you for the explanation.

Kind regards
Tigran

