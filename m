Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbVKDIua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbVKDIua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161105AbVKDIua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:50:30 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:42770 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161101AbVKDIu3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:50:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sg9FBio5lOEym22IK40M4OkeJbiyQqrfjzWyrb9GFIu/gDvnPbkW8SwlrzEyC/CDQE2x9j5JBBzyZWrYsPomqALmyn44Y9AlUgMfs0rMczQOccvR5qKEU068jxISN3K+HBNvG5l/UKQ4n0qbCDr/usddsMfswmX8yF7xY8tmgQM=
Message-ID: <7cd5d4b40511040050m4a0471e7pc032f8ef54fa7be3@mail.gmail.com>
Date: Fri, 4 Nov 2005 16:50:29 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: why we set current->state = TASK_RUNNING in handle_mm_fault?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
But I notice before version 2.4.0,this is not set.
Thanks.

Jeffshia
