Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVGUVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVGUVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 17:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVGUVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 17:15:58 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:35671 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261888AbVGUVPb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 17:15:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tAdVHOtSo/XFxCanZ5tcEmey3ezZ10Pbl4gLqLkcy8Dtk3nuws/eW8e+wAhI8xf7FomVo8AYvZK/fizwRsRclexHGL26psCB2M8gq/3TJboWxYHWzyVDNiyqiLWlBxeAGj1qAsRKOI6lQYOwyxBEiWjtJAtG4JrVSOEtNK/qrZ0=
Message-ID: <c25ab84c05072113494c02846d@mail.gmail.com>
Date: Thu, 21 Jul 2005 13:49:28 -0700
From: Danny Yu <dkyu80@gmail.com>
Reply-To: Danny Yu <dkyu80@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to change the value of IPCMNI?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 


Is there any ways to change IPCMNI in include/linux/ipc.h . 
It is currently at 32768, and it is not big enough for my 
implementation. 


Thx for the help.
