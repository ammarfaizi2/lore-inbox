Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSIEOcS>; Thu, 5 Sep 2002 10:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSIEOcS>; Thu, 5 Sep 2002 10:32:18 -0400
Received: from relay03.esat.net ([193.95.141.41]:12818 "EHLO relay03.esat.net")
	by vger.kernel.org with ESMTP id <S317610AbSIEOcR>;
	Thu, 5 Sep 2002 10:32:17 -0400
Message-ID: <3D776C36.20509@palamon.ie>
Date: Thu, 05 Sep 2002 15:37:42 +0100
From: Tony Clarke <sam@palamon.ie>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smp and tulip driver problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
    Having some problems with an ethernet card, netgear,
    (Ethernet controller: Lite-On Communications Inc LNE100TX (rev 33)),
    when running under smp. This is with stock redhat 7.3 distro.
    Seems to be running the tulip driver .9.15.-pre10. Under heavy
    ethernet usage, the system just hangs. Is there known isssues
    with the tulip driver?

Cheers,
Tony.


