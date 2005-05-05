Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVEEUtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVEEUtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 16:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVEEUtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 16:49:40 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:1246 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262184AbVEEUtj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 16:49:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ZcjV/cQo+M4AvPzURGyxMsA3iqaMvsxqMSozfHVxZup5VMFX6vovmtyDyHBtC/24q6wx0nLbZBGoWG4TiY+6SLRaL0KqDWIuura+dmVJPqoRbv4TqOpTnqqY+EVPkqYoQJUbld5P2kq6+J7c70RFayQENLb0gAQKgF48vwbkwNU=
Message-ID: <4ae3c1405050513493b5a1b88@mail.gmail.com>
Date: Thu, 5 May 2005 16:49:33 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: does e2fsprogs needs to invoke file system related system calls?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does e2fsprogs needs to invoke file system related system calls?

The reason I want to ask this question is to know whether we can
bypass the system call monitoring based access control with e2fsprogs.

Thanks
-x
