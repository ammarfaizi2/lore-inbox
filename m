Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbVJ1G7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbVJ1G7f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVJ1G7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:59:35 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:5559 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965124AbVJ1G7e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:59:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ELpI6EHykxmpDrl9pMM68Q4DndUaChouLS0OgpdgXFcQlWMAuMB6BOc8AfIWoDwmKhW4Rku82XIxL+l8XCcKLI3n8Wi+zHTUV2gkZLmSkZ704emIKfjgCBym0BhW0gSZyUGWm8ZQvpz+AA9vhmyoaoqOBItP3eQunu7YXvZcKys=
Message-ID: <b681c62b0510272359w4ad32bb3p4eba47a33bb030f0@mail.gmail.com>
Date: Fri, 28 Oct 2005 12:29:33 +0530
From: yogeshwar sonawane <yogyas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: deletion of device file from /dev after reboot
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

I am trying a pseudo character driver. But after reboot, my device
file from /dev directory is getting deleted. This is for 2.6 kernel.
Is there a way to create a file permanently which will be not deleted
after reboot? Earlier in 2.4, this was not the case.

Thanks for any help,
Yogeshwar
