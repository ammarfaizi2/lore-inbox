Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTDPSmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTDPSmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:42:20 -0400
Received: from freeside.toyota.com ([63.87.74.7]:38862 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP id S264518AbTDPSmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:42:19 -0400
Message-ID: <3E9DA6CC.3030700@tmsusa.com>
Date: Wed, 16 Apr 2003 11:54:04 -0700
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: RedHat 9 and 2.5.x support
References: <20030416165408.GD30098@wind.cocodriloo.com> <1050511742.15637.24.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Wed, 2003-04-16 at 12:54, Antonio Vargas wrote:
>
>  
>
>>I've just installed RedHat 9 on my desktop machine and I'd like
>>if it will support running under 2.5.65+ instead of his usual
>>2.4.19+.
>>    
>>
>
>Other than modutils(*) there are no issues with RH9 and 2.5.  I am
>running RH9 with 2.5 on my daily workstation.
>
>Even NPTL, sysenter, and all the other goodies work flawlessly.  It is
>quite nice.
>

Bestaetigt!

RH9 + 2.5.67-mm is quite nice here - apache,
squid, postfix, iptables, openvpn, bind - and a
very snappy X11 desktop -

The only extra requirement is rusty's module
init-tools.

Joe

