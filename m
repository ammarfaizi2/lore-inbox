Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbULaRlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbULaRlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbULaRlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:41:53 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:22314 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbULaRlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:41:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=AYxW07vi2xx7X2N9ENrUSbr8isE+SZipyfp0MtHEVwfTfeVozpC9Pkaod1GQ1d84App/dz1Mstgu0NH+YKlUw1vnpZekGg6tORpxW6e/WSS724KWY8RvOjHgQavjWlqgyYb5HZ+UaLWbdWQO1uP/NhECVQ6MG02vo+CUoUZSAqk=
Message-ID: <2d7d2dd20412310941724cc1cb@mail.gmail.com>
Date: Fri, 31 Dec 2004 17:41:43 +0000
From: Simon Burke <simon.burke@gmail.com>
Reply-To: Simon Burke <simon.burke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: /tmp as ramdisk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stupid question really.

On my servers I'd like to mount /tmp as a ramdisk, for several
reasons. How would i go about this with linux? Is it as simple as
putting it in the /etc/fstab? where do i define the size of such a
disk?
-- 
Theres no place like ::1

Thanks,
SimonB
