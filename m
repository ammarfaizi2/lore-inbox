Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVI0Rkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVI0Rkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVI0Rkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:40:45 -0400
Received: from fw.archivum.info ([213.41.128.193]:36586 "EHLO
	smtp.trashmail.net") by vger.kernel.org with ESMTP id S965029AbVI0Rkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:40:45 -0400
Date: Tue, 27 Sep 2005 19:40:32 +0200
To: linux-kernel@vger.kernel.org
Subject: 128 kbytes allocation limit for kmalloc?
Message-ID: <20050927174032.GA26236@archivum.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: mailarch@archivum.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is it possible to allocate more than 128 kbytes in a kernel lkm module?
When I allocate more than 128 kbytes with the kmalloc call, kmalloc returns NULL.

-- 
Best regards,
Stephan Ferraro
NOOFS Core Developper
http://www.noofs.org/
