Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311150AbSCHVsG>; Fri, 8 Mar 2002 16:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311151AbSCHVr4>; Fri, 8 Mar 2002 16:47:56 -0500
Received: from freeside.toyota.com ([63.87.74.7]:50953 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S311150AbSCHVro>; Fri, 8 Mar 2002 16:47:44 -0500
Message-ID: <3C893171.2050003@lexus.com>
Date: Fri, 08 Mar 2002 13:47:29 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: root-owned /proc/pid files for threaded apps?
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:

>As a side note, IMHO it would be sensible to have some way of
>disabling module autoloading of protocol modules in the network stack.
>

What is the problem with using modules.conf e.g.

alias net-pf-10 off

?

Joe

