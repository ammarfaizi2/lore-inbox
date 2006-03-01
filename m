Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751869AbWCATxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbWCATxT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCATxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:53:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:59481 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751869AbWCATxS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:53:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Kmdqp3+/gb0NKdYR27s1tEZ1dovMmwBo47tyD/AqlixUPhykh7ZGE5pyDVqG2k0BKhSY5y2ow2almNlmxd5YNzZXYTixNh2xUitR+cp8E+4VzcpJ9uS/qd3mWPpHdDiOTO4mc3VbTYPp3/DJOKw9Xba3eL6h12TOSciYYFF4FM8=
Message-ID: <4ae3c140603011153i63770328w55038278fea1581@mail.gmail.com>
Date: Wed, 1 Mar 2006 14:53:17 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is there any tool that can audit file system activities?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to get some statistics of file system activities. But I don't
want to write too much code to do this. Instead, I would like to use
some existing tool.

Can someone kindly recommend a good tool to do this? Many thanks!

Xin
