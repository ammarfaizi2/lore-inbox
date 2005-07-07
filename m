Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVGGMxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVGGMxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVGGMtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:49:09 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:21448 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261414AbVGGMrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:47:23 -0400
Date: Thu, 7 Jul 2005 14:46:32 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Jakub Jelinek <jakub@redhat.com>
Cc: raja <vnagaraju@effigent.net>, linux-kernel@vger.kernel.org
Subject: Re: ipc
Message-ID: <20050707144632.50483529@localhost>
In-Reply-To: <20050707122747.GR3720@devserv.devel.redhat.com>
References: <42CD12A7.90106@effigent.net>
	<20050707141302.1f40eb89@localhost>
	<20050707122747.GR3720@devserv.devel.redhat.com>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005 08:27:48 -0400
Jakub Jelinek <jakub@redhat.com> wrote:

> If you have glibc 2.3.4 or later, you should use -lrt instead.

Yes... I was just saying that he forgot to add "-lLIBRAY_NAME" :)

-- 
	Paolo Ornati
	Linux 2.6.12.2 on x86_64
