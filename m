Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTDWPfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264018AbTDWPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:35:43 -0400
Received: from matrix01.home.net.pl ([212.85.112.31]:24077 "HELO
	matrix01.home.net.pl") by vger.kernel.org with SMTP id S264080AbTDWPfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:35:42 -0400
Message-ID: <3EA6B5C1.1040903@post.pl>
Date: Wed, 23 Apr 2003 17:48:17 +0200
From: "Leonard Milcin, Jr" <thervoy@post.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: FileSystem Filter Driver
References: <000501c30983$1ffb8950$ade1db3e@pinguin> <1051092516.1896.7.camel@abhilinux.cygnet.co.in> <20030423.11473966@knigge.local.net>
In-Reply-To: <20030423.11473966@knigge.local.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Knigge wrote:
> Hi,
> 
> 
>>What's a FileSystem Filter Driver?
> 
> 
> This is a driver that intercepts calls to the filesystem - for example 
> for monitoring or to do additional access checks. Such a filter driver 
> can then pass the call down to the filesystem or just cancel the call 
> and (for example) return "access denied".

Nice. I wonder if there is some open-source project with aim in building
audit tool based on that idea. It will be very nice to have one, and I 
think it will be very interesting, especially for corporate users. I 
will search for information about this, and if I find nothing, maybe 
this is a good moment to start that project? The aim will be building 
kernel driver + user-space tool to provide 1) ultimate filesystem audit 
tool, 2) user space access control manager. This will help linux to 
conquer with proprietary products.

What you're thinking about it?



Leonard,


