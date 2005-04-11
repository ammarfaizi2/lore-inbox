Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVDKPaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVDKPaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDKP37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:29:59 -0400
Received: from [81.2.110.250] ([81.2.110.250]:52379 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261803AbVDKP3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:29:50 -0400
Subject: Re: Overcommit_memory logic fails when swap is off
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42525107.6060807@egholm-nielsen.dk>
References: <42525107.6060807@egholm-nielsen.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113233235.9885.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Apr 2005 16:27:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-04-05 at 09:49, Martin Egholm Nielsen wrote:
> As I can see, the patch never made it in 2.4.x, right?!
> So, I would like a diff - if still possible :-)

I submitted it ages ago but it was rejected and punted to 2.6. The 2.4
support is available in Red Hat Enterprise Linux 3, so you can pull it
out of the source rpms on the ftp site or out of Centos etc

Alan

