Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVCHU66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVCHU66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVCHU5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:57:00 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:12959 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262277AbVCHUxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:53:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pczeHXTun3Z4YWW6O51ueE+9JnumiDGWdVON/NUBU/Bw/ZQUehHuwiSCZfnCyuPik0bQHEi1ICTyIikhp2ZJk5ENrEfYUh8AsuebbFG5Rs6+UKcF1B/YAirgB7sw3gIlICk6DPLL9EbhX+jkxLYXWH+rHhBUeGl/xbOID73WZXk=
Message-ID: <9e4733910503081252737391ce@mail.gmail.com>
Date: Tue, 8 Mar 2005 15:52:56 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer Splash
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@www.infradead.org>
In-Reply-To: <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050308015731.GA26249@spock.one.pl>
	 <Pine.LNX.4.56.0503081945510.15646@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 19:46:23 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> What are you trying to do exactly? I really don't see the point of this
> patch.

I think it makes a graphical background on your console that stays in
place as the console text scrolls.

-- 
Jon Smirl
jonsmirl@gmail.com
