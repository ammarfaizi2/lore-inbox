Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbULMB1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbULMB1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 20:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbULMB1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 20:27:47 -0500
Received: from pop3.telefonica.net ([213.4.129.150]:7883 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S262185AbULMB1p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 20:27:45 -0500
Message-ID: <41BCF04A.3060506@telefonica.net>
Date: Mon, 13 Dec 2004 02:28:42 +0100
From: =?ISO-8859-1?Q?Antonio_P=E9rez?= <aperlu@telefonica.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-net@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: proc/sys/net/ipv4/tcp_bic
References: <41BA0245.4050502@lougher.demon.co.uk> <20041211013323.GA12796@kroah.com> <41BA825F.9040509@lougher.demon.co.uk> <20041211153922.GA29523@kroah.com> <41BB186C.4000105@telefonica.net>
In-Reply-To: <41BB186C.4000105@telefonica.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How affect the value of the file proc/sys/net/ipv4/tcp_bic if I want to 
do masquerade?
Is possible  that if proc/sys/net/ipv4/tcp_bic=1 the tcp connections 
don't work fine if I do masquerade?

Thanks.
