Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTHUPJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 11:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTHUPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 11:09:27 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:34944 "EHLO
	alphaworks.anomalistic.org") by vger.kernel.org with ESMTP
	id S262729AbTHUPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 11:09:14 -0400
Date: Thu, 21 Aug 2003 23:09:10 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Random hangs in 2.6.0-test3-mm3
Message-ID: <20030821150910.GA1520@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <20030821045444.GA465@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821045444.GA465@eugeneteo.net>
X-Operating-System: Linux 2.6.0-test3-mm3
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have disabled Local APIC support. So far so good. Will keep 
you guys updated.

<quote sender="Eugene Teo">
> Hi guys,
> 
> I am back. This time, I built a new box. It's an
> AMD XP 2400+ on ASUS A7N8X. I tried the same 2.6.0
> configuration as my Fujitsu E-7010 laptop, and again,
> I experienced random hangs. I have done memtest86
> on both, and there are no errors. I am very sure that
> my new box is working fine, same goes to my laptop.
> This time, I am unable to get any debugging messages,
> but will do so the next time I experience the same
> problem again.
> 
> Attached is my config file. Please take a look, and
> try to see if you get random hangs. It might hang
> on yours too. 
> 
> # ASUS A7N8X
> # AMD Athlon(tm) XP2400+
> # Kingston KVR333X64C25 512MB
> # Nvidia GeForce4 MX 440 DDR 8X 64M W/TV-Output
> # Western Digital 80GB
> # Linux alphaworks 2.6.0-test3-mm3 #4 Thu Aug 21 09:38:03 SGT 2003 i686
> # GNU/Linux
> 
> Let me know what other information you need.
> 
> Eugene
> -- 
> Linux alphaworks 2.6.0-test3-mm3 i686 GNU/Linux
