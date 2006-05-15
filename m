Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWEOX5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEOX5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWEOX5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:57:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:53666 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750832AbWEOX5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:57:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g0vh9tp1T/AcJvZozhUc05TNE3/yFOHV+lQClAlHWK5cTsE+CXjetW0zD9jts5/QPxySBK+ac6E2M3r9FYclq30mfnddkfzBVi2opnce8Q4BnN44jDeDZjuRaqZQCZzeZgj7NQs7KJskbnk6lD8srPJNdjw5WQGnoW83vDkSZDY=
Message-ID: <4ae3c140605151657m152c0e7bl7f52e2a2def0aeca@mail.gmail.com>
Date: Mon, 15 May 2006 19:57:21 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: HELP! vfs_readv() issue
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am writing a file system, but vfs_read() sometimes return 0. What
could cause this problem?

Please help!

Xin
