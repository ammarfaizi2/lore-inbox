Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbTICPlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263536AbTICPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:41:36 -0400
Received: from mail.ecommerce.com ([213.208.20.32]:3740 "HELO
	mail.ecommerce.com") by vger.kernel.org with SMTP id S263505AbTICPkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:40:49 -0400
Date: Wed, 3 Sep 2003 05:40:40 +0200
From: Dumitru Stama <dics@ecommerce.com>
X-Mailer: The Bat! (v1.60c) Personal
Reply-To: Dumitru Stama <dics@ecommerce.com>
Organization: Ecommerce
X-Priority: 3 (Normal)
Message-ID: <123-216863213.20030903054040@ecommerce.com>
To: linux-kernel@vger.kernel.org
Subject: Binary modules for 2.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all
Everything i write in the next lines can be considered as a question
also since this is what i come to find out studying the latest 2.6
kernel.
With the current layout of the kernel modules there will be no way of
distributing binary kernel modules anymore. Considering the structures
that combine to describe the way module works and the alignement of
those depending on the processor type even if that processor is i386
compatible. Personally i think this is a good move for open source
community but what are we gona do with the proprietary drivers that do
not have the sources available ?
If i am mistaken by any chance please enlighten me.

Thanks
Dumitru Stama

