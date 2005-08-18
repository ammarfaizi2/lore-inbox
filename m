Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVHRIkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHRIkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVHRIkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:40:21 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:62836 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932116AbVHRIkV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:40:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SZun1Pg8chOZpyz8xGmqoXC2O1G6tbu7PxTnhqJC1MqtoczbiWj2HILsbu2wbScmALH2tdW0WYF66j1nHvIMRt+xDNYXkGHaiTQrvbgMg+KIv+mrQUz1v1HGg0M+I31whxdJN9JGSfzQ6hD9lfj9IWrt/COmTtqUG69ubZYPh9w=
Message-ID: <7cd5d4b4050818014042740322@mail.gmail.com>
Date: Thu, 18 Aug 2005 16:40:20 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: can I write to the cdrom through writing to the device file sr0?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to write a cdrw user space driver just like cdreord,but the
cdrecord is too complex and huge!can I write to the cdrom through
writing to the device file sr0,here sr0 is the device file of the
cdrw.
