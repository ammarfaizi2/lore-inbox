Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVJBUu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVJBUu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVJBUu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:50:57 -0400
Received: from main.gmane.org ([80.91.229.2]:53717 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932067AbVJBUu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:50:56 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lexington Luthor <lexington.luthor@gmail.com>
Subject: Re: A possible idea for Linux: Save running programs to disk
Date: Sun, 02 Oct 2005 20:21:47 +0100
Message-ID: <dhpc0j$i24$1@sea.gmane.org>
References: <433F0BF1.2020900@concannon.net> <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: bb-82-108-13-253.ukonline.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
In-Reply-To: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lokum spand wrote:
> 
> In fact moving processes from one machine to another would be a 
> brilliant feature at my work, since we run fairly large and 
> time-consuming simulations on electronic circuits. If the kernel could 
> natively support bouncing jobs back and forth, that would really be 
> something. Since we simulate with proprietary software, I suppose we 
> can't rely on the simulator being rewritten to support such special 
> libraries.
> 

The OpenSSI patches to the Kernel can make a network of machines behave 
like a single system image with automatic process migration, among other 
things.

http://openssi.org

Regards,
LL

