Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUJFO6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUJFO6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269282AbUJFO6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 10:58:45 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:31220 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269281AbUJFO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 10:58:44 -0400
Message-ID: <41640813.8030007@nortelnetworks.com>
Date: Wed, 06 Oct 2004 08:58:27 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patryk Jakubowski <patrics@interia.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6.9
References: <S268296AbUJDTjb/20041004193948Z+2396@vger.kernel.org> <41630B2C.5020709@interia.pl> <4163619C.4070600@vgertech.com> <4163A3E2.2060609@stud.feec.vutbr.cz> <4163C574.50805@interia.pl> <20041006110721.GC4380@vana.vc.cvut.cz> <4163D8BB.8080507@interia.pl>
In-Reply-To: <4163D8BB.8080507@interia.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patryk Jakubowski wrote:

> I think this should be fixed in stable kernel version, but it isn't. I 
> have consulted this problem in a forum. Few people can reproduce the 
> bug. They have kernels 2.6.7, 2.6.8. I am pretty sure I have kernel 
> 2.6.9-rc3 from kernel.org :) I downloaded it to check if the bug is not 
> fixed.

It works fine for me with 2.6.9-rc3, but I'm not using NPTL.

Chris
