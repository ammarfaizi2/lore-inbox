Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVAJB2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVAJB2O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVAJB2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:28:14 -0500
Received: from mproxy.gmail.com ([216.239.56.248]:37075 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262041AbVAJB2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:28:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=bieR3IW0nxerZzMjuSrVImB6jMECo0tOyVVw37b5ElzzomZO1Wb8KZYIH0CEVknWFufEUBkPUF9PF/FJ9Y+OqQ/+7iVM3zA9iPbS+UulVyu1E7+kAqiIHg4CKN64jy2WzOvE6g0FyOEG+tQ/MsSOdfOCOAqQ+iXAoDqVOJ17UAI=
Message-ID: <21d7e99705010917281c6634b8@mail.gmail.com>
Date: Mon, 10 Jan 2005 12:28:06 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: starting with 2.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, znmeb@cesmail.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E1CCB7.4030302@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
	 <1105115671.12371.38.camel@DreamGate> <41DEC5F1.9070205@comcast.net>
	 <1105237910.11255.92.camel@DreamGate> <41E0A032.5050106@comcast.net>
	 <1105278618.12054.37.camel@localhost.localdomain>
	 <41E1CCB7.4030302@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what 3rd party hardware vendor wants to waste their resources by
> repeting smaller versions of the one-time cost of driver writing over
> and over to accomodate linux, when they can't even accomodate all
> versions due to special patches some people have?  So far there's been a
> rediculous but visible trend of hardware vendors to hold their source
> closed.

I do wonder would open source kernel drivers to work with a closed
source user space application be accepted into the mainline kernel...
say for example Nvidia or VMware GPL'ed their lower layer kernel
interfaces but kept their userspace (X driver and VMware) closed
source which is perfectly acceptable from a license point of view..
would Linus/Andrew accept the nvidia lowlevel into the kernel, if not
then it would be idealogical not licensing issues which would make the
argument for having a stable module interface better :-)

It would be interesting to find out .. and you are right there is
little point in arguing this at this stage, closed source drivers are
evil.

Dave.
