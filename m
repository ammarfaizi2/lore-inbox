Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbULHQ54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbULHQ54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbULHQ5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:57:55 -0500
Received: from [62.206.217.67] ([62.206.217.67]:23710 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261265AbULHQ5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:57:48 -0500
Message-ID: <41B73263.4040706@trash.net>
Date: Wed, 08 Dec 2004 17:57:07 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: "David S. Miller" <davem@davemloft.net>, tgraf@suug.ch, akpm@osdl.org,
       tomc@compaqnet.fr, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
References: <1102380430.6103.6.camel@buffy>	 <20041206224441.628e7885.akpm@osdl.org>	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>	 <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net>	 <20041207213053.6bb602c1.davem@davemloft.net> <1102507470.1051.27.camel@jzny.localdomain>
In-Reply-To: <1102507470.1051.27.camel@jzny.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>I can almost guarantee that one or more of those tests i outlined would
>fail. So i would suggest a revert until the testing has been done.
>
Please be more specific than an "almost guarantee" that
"one or more tests" may fail when asking to revert a patch
that fixes an easily triggerable crash. For example, point
to the code that makes you think it might fail.


