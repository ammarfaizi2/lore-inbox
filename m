Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266106AbUALKVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUALKVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:21:17 -0500
Received: from viper.first4it.co.uk ([212.69.243.52]:13222 "HELO
	viper.first4it.co.uk") by vger.kernel.org with SMTP id S266106AbUALKVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:21:02 -0500
Message-ID: <40027510.1080600@ihateaol.co.uk>
Date: Mon, 12 Jan 2004 10:21:04 +0000
From: Kieran <kieran@ihateaol.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: uk keyboard broken by input updates?
References: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
In-Reply-To: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have exactly the same problem using 2.6.1 and an IBM USB keyboard, not 
really had a chance to look into it yet though.

> Hello,
> 
> 2.6.1 broke the ~/# key on my UK keyboard, when it used to work fine on
> 2.6.0. The key is now acting as Print Screen/SysRq. The keyboard is
> connected as PS/2 (though it is also plugged as USB, it's a Logitech
> wireless keyboard, with the receiver being the same for the mouse and
> keyboard).
> 
> I didn't look at the changes made to the input layer in details. Could
> anyone shed some light on this problem?
> 
> Cheers

