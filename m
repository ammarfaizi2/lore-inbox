Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbUKXHkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbUKXHkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 02:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUKXHid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 02:38:33 -0500
Received: from colino.net ([213.41.131.56]:6389 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262342AbUKXHf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 02:35:58 -0500
Date: Wed, 24 Nov 2004 08:30:57 +0100
From: Colin Leroy <colin.lkml@colino.net>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124083057.5cddd4d9@pirandello>
In-Reply-To: <E1CWpuE-0002Tu-00@calista.eckenfels.6bone.ka-ip.net>
References: <87pt237se1.fsf@devron.myhome.or.jp>
	<E1CWpuE-0002Tu-00@calista.eckenfels.6bone.ka-ip.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs163.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004 at 06h11, Bernd Eckenfels wrote:

Hi, 

> Hmm... Actually a "better" solution which involves a journalling filesystem
> is not an option for most fat users becaue they need the interoperability.

Yes, an usb key with ext2 fs is quite useless when you have to tell your 
friends they can't give you this or that file because they run windows :)

-- 
Colin
