Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264425AbSIQRnW>; Tue, 17 Sep 2002 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264436AbSIQRnW>; Tue, 17 Sep 2002 13:43:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264425AbSIQRnW>; Tue, 17 Sep 2002 13:43:22 -0400
Message-ID: <3D876ADD.9090800@transmeta.com>
Date: Tue, 17 Sep 2002 10:48:13 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Padraig Brady <padraig.brady@corvil.com>
CC: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH][2.5.35] CPU frequency and voltage scaling (0/5)
References: <20020917113047.C25385@brodo.de> <3D870734.9080301@corvil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Padraig Brady wrote:
> 
> This is much better, but I preferred Dave Jones' suggestion of
> supporting stackable policies as I can see no end to them:
> max_cpu_temp, temp_hysteresis, favor_fast_{fsb,multiplier}, ...
> 

It would be especially interesting if the policy name can be a loadable 
module (via kmod.)

	-hpa


