Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVIQJZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVIQJZx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 05:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVIQJZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 05:25:53 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:41800 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750992AbVIQJZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 05:25:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=sICGBm4n13ri0h9bv3Yh9eQbbmetXBA+E/zLVyWSvyJZUbyMOSlq9AXAsMvMluIpUsE3+L6XuTiocy7V9r4oNLU7QPIUPtJWvqYZTOsMod0psN90eCQ/0oubL8xIIUGF63O3R1fMGidKfX6BzdEtLqApudYAPVdpD4zyNyn0XFU=
Message-ID: <432BE118.5090008@gmail.com>
Date: Sat, 17 Sep 2005 11:25:44 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc1 Critical bug: machine complete freeze
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

i'm using 2.6.14-rc1.

1 second after starting samba (3.0.20) machine freezes completly.
no way to resume it, just hardware reset.

I can't provide backtraces or logs, there isn't a logged kernel panic, 
nor other log.
Immedially freezed.

2.6.13 works.

Of course same smb.conf and same .config.




