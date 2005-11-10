Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVKJNQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVKJNQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVKJNQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:16:42 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:12512 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750838AbVKJNQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:16:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=CdzS22AQq5Nsu8QlJhJ8ubabVW7BPosVHJnOPBazU0KzBgaj7LyWItOil+4BituZHDIlQZ6sc3SZR6996GLPzk9gms40t/gP3xmE0PdmOGjQ0L+31tthZwEvWZPGgDckc5DuEprUOZ1LYHrjf3OeWbPjjAUikBQBtILnyvJGJSI=
Message-ID: <437347B5.6080201@gmail.com>
Date: Thu, 10 Nov 2005 21:14:29 +0800
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: MOD_INC_USE_COUNT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Tony <tony.uestc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
Usually, when a net_device->open is called, it will MOD_INC_USE_COUNT on 
success. It is removed since 2.5.x, then should I increase the use 
count? how? thx.
