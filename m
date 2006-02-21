Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161213AbWBUAHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWBUAHq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWBUAHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:07:46 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:51000 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161213AbWBUAHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:07:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DqJ3KqTY6dwz/X6nHBFHC859zhCPQi+mNrtcOjj4gLY1sUkahLCWST8DPzGpozZJEoK71KtkgcwctptcfIza3BV5/ZXy03LH05doVVN8pvHnOTU/V6Q8Sz7YJi6M78OGaJrRJLiaFWirBaxyaRruVh1+5Z3AE//wvjrdLi7UjNw=
Message-ID: <43FA59C2.8090500@gmail.com>
Date: Tue, 21 Feb 2006 08:07:30 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mozilla Thunderbird posting instructions wanted
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
In-Reply-To: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> This  POS is pretty popular among kernel janitors, so, can someone who
> is successfully using it, please, post crystally clear step-by-step
> instructions on how to send a foo.patch:
> 	inline
> 	with tabs preserved
> 	with long lines preserved
> 
> Sending plain text attachments is OK with me, but, heh, people do post
> patches inline and screw themselves.
> 
> I'll put instructions somewhere on -kj website and point every
> unsuspecting new guy to them.
> 

I've been sending patches inline with thunderbird.  Most important setting
is "wrap plain text messages at 0 characters".

Getting the external editor extension makes the job much easier. It allows
you to use your favorite editor while in the compose window.

Tony
