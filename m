Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTJERls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTJERls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:41:48 -0400
Received: from sisko.nodomain.org ([213.208.99.114]:47004 "EHLO
	mail.nodomain.org") by vger.kernel.org with ESMTP id S263227AbTJERll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:41:41 -0400
Message-ID: <3F8057CA.4040007@nodomain.org>
Date: Sun, 05 Oct 2003 18:41:30 +0100
From: Tony Hoyle <tmh@nodomain.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.4) Gecko/20030930 Debian/1.4-5
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andi Kleen <ak@colin2.muc.de>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com.br
Subject: Re: Oops linux 2.4.23-pre6 on amd64
References: <Pine.LNX.4.44.0310051420110.1408-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0310051420110.1408-100000@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> 
> What problem are you seeing Tony? Oopsing right? Where is the oops output?
> 
> 
Random segfaults, internal compiler errors, general instability.  It was 
impossible to compile a kernel without something breaking...  when 
oopses happend they usually happened 3 or 4 in a row.

It's been steady as a rock since I removed devfs...

Tony

