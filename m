Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTFGIlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 04:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTFGIlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 04:41:23 -0400
Received: from colina.demon.co.uk ([80.177.30.27]:47497 "EHLO
	colina.demon.co.uk") by vger.kernel.org with ESMTP id S262776AbTFGIlX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 04:41:23 -0400
To: linux-kernel@vger.kernel.org
Subject: Maximum swap space?
From: Colin Paul Adams <colin@colina.demon.co.uk>
Date: 07 Jun 2003 09:55:12 +0100
Message-ID: <ltptlqb72n.fsf@colina.demon.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am somewhat confused about how much swap space you can have with a
2.4 series kernel. If I read the mkswap man page, I get the impression
that I could have up to 8x2GB of swap space for a total of 16 GB, but
reading the RedHat reference guide, it says 2GB maximum.

I presume 2.5 kernels have much higher limits?
-- 
Colin Paul Adams
Preston Lancashire
