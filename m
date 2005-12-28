Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVL1N5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVL1N5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVL1N5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:57:53 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:51223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964815AbVL1N5x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:57:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K6rijBHXXE94iV9Wd7addDDHG4UpauytFg4jCyt8+TUk+zSdVwjuXg3ci1b+WRO4oBOuP/cauxq2wN7zpc9PMU5eOM5//cMY3ydiS8hhGeDjWcnsZaCHTxcO8ag9xIpA+7mFvedfZxN4AJqJAcOO4lR6VCiJyQRKASqWFE8aIJE=
Message-ID: <c2bc1f40512280557w44d41e8fm58273fb96a1b6726@mail.gmail.com>
Date: Wed, 28 Dec 2005 21:57:51 +0800
From: jeanwelly <jeanwelly@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to debug FTP messaging in Linux FTP server
In-Reply-To: <c2bc1f40512280455w67b3db2cx4de6e32d50f5b760@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c2bc1f40512280455w67b3db2cx4de6e32d50f5b760@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All
I am using PowerPC target board and want to transfer files from board
to a Linux FTP server.
The current issue is that FTP server returns ERROR when I sending
"STOR filename" from client.
But command "TYPE type", "PASS password" and "USER username" can work
correctly between board and server.

My question is how can I debug  or what tools can be used in Linux
server to track what's going on in server.
I guess there should be a lot of scenarios which can caused the STOR
command get error return code, I appreciate if you can list some.

Thanks!

--
Jeanwelly
Email:jeanwelly@gmail.com
Nortel China
