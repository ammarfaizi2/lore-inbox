Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVIIMkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVIIMkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbVIIMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:40:31 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:43971 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751389AbVIIMka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:40:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ak+cJ1paaZb64YKENDANx0vP1s3Xrhw7Y6BN7CDNyV5jb71PeT81pD0ixaIYC/575+uhyzjOhO9/ZRQ1FBK7vNbrjLVn+r7sFbZooEJNDDprmiapGnypq6i5rJQHMcorfXa7V29kaL83Z49wIdtAu48se80z4vxxUzBGGyEtHxY=
Subject: Debugging
From: Lares Moreau <lares.moreau@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 09 Sep 2005 06:40:25 -0600
Message-Id: <1126269625.9305.2.camel@jove>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OKay this is a noobie question,

I have all the kernel debugging options turned.  Now how do I change the
kernel logging level from prompt?  Or do I?

I have 'loglevel=7' appended to my kernel line in grub.  Is that all I
need or is there more to it?

Worry not I have syslog-ng setup properly

-Lares

