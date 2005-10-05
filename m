Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVJEAmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVJEAmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVJEAmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:42:14 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:49273 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965052AbVJEAmM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:42:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sK0/Es7OS3fEFVjhuaNRNw7hcfDkkI9gTdhV9LUjz9HvYYLuz289/JUToSSqBLCCqlZiFnbX/PbY3DaDcxjVj2mWddepHVsqty+rTAFGcGVWSNUJB1E9gd6IY+VMfJMLnCoeMA+foeCCw/lzvDlSNp84q/uq1mjfkWSejv5U16g=
Message-ID: <bac30fa90510041742w558f4e55n@mail.gmail.com>
Date: Tue, 4 Oct 2005 21:42:11 -0300
From: Redes II <redes2k@gmail.com>
Reply-To: Redes II <redes2k@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 kernel_thread() question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Does kernel_thread detach the new Kernel thread from its parent?
Does something like pthread_detach(tid) exist in Kernel module's programming?
Thanks

Kernel: 2.6.13
Architecture:i32
