Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVEILRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVEILRr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVEILRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:17:47 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:59500 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261246AbVEILRp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:17:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qyRLZA89hUUlbWD3BMKmaWG9RglGxqWvncd/JqER8mLytfoBpf6+4a3eJ7/qEg9VyT8XvxqAVqc7FHoCa5mlJ0g3M9cY4imVFQ6aIu6giQxSHkvwOtm+TlwjyQ1JSLOAuP+guiwd42M35VHB9EPAfstQd55nljlJQRaQk22epO0=
Message-ID: <5eb4b06505050904172655477c@mail.gmail.com>
Date: Mon, 9 May 2005 19:17:44 +0800
From: KC <kcc1967@gmail.com>
Reply-To: KC <kcc1967@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: proc_mknod() replacement
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that proc_mknod() had been removed from kernel 2.6.x.
Any replacement ?

Or how can I create file, device node or dir from device driver ?

Thanks


Regards
KC
kccheng@LinuxDAQ-Labs.org
