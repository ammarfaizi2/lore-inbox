Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTKHUNe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTKHUNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:13:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:50695 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262592AbTKHUNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:13:33 -0500
Date: Sat, 8 Nov 2003 21:13:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Karl <ktatgenhorst@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing asm-generic during make config
Message-ID: <20031108201331.GA941@mars.ravnborg.org>
Mail-Followup-To: Karl <ktatgenhorst@comcast.net>,
	linux-kernel@vger.kernel.org
References: <NDBBJHDEALBBOIDJGBNNCEGFCJAA.ktatgenhorst@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NDBBJHDEALBBOIDJGBNNCEGFCJAA.ktatgenhorst@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 11:07:10AM -0500, Karl wrote:
> Hello,
> 
>     I am a list newby and did look for this info, I apologize if my search
> was just not good enough. I have installed 2.6.0 test 9 on 2 machines of
> mine. One is a gateway Pentium II PC and the other is an IBM Netfinity
> server. In both cases when I tried running make config I was given the
> message (I apologize I went on and am paraphrasing) asm-generic/errno.h no
> such file.
Strange, not reproduible here.
Could you please try 'make V=1 config' and post the output.
Eventually in private mail, it may be several pages.

	Sam
