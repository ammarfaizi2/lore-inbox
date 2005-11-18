Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVKRDzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVKRDzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKRDzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:55:42 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:13189 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbVKRDzl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:55:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RlQkV+hMXJMNyuJDThF47IWlXyzPujeXdviBLK2a7UUqfD2gdDhkgXc5ngrqJGOSS9uRkJkBbfpwDCAw463DGX4ZOBDyme3xRPNhUDNRIA4cMChCWrl1xoxRch2U0NNznoKeaqdMbz29BGemWCjHua6z6Td7uEf8yyNpeJyM5HU=
Message-ID: <7cd5d4b40511171955y7787b880i53d89c35a0629b3d@mail.gmail.com>
Date: Fri, 18 Nov 2005 11:55:40 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: can we sleep at the bottom half environment?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
      can we sleep at the bottom half environment?such as in a softirq
or a workqueue? why?
     Thank you!

jeffshia
