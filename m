Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUD2Cgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUD2Cgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUD2Cgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:36:47 -0400
Received: from ptb-relay02.plus.net ([212.159.14.213]:6670 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S262422AbUD2Cgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:36:46 -0400
Message-ID: <40906A35.3090004@mauve.plus.com>
Date: Thu, 29 Apr 2004 03:36:37 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Rik van Riel <riel@redhat.com>, Timothy Miller <miller@techsource.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <4150E18A-9985-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <4150E18A-9985-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> Hi Rik,
> 
> Your new proposed message sounds much clearer to the ordinary mortal and 
> would imho be a significant improvement. Perhaps printing repetitive 
> warnings for identical $MODULE_VENDOR strings could also be avoided, 
> taking care of the redundancy/volume problem as well..

Is this worth 100 or 200 bytes of code though?
I'd have to say no.

