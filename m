Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVKFAjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVKFAjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKFAjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:39:01 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:17882 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbVKFAjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:39:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SWScmlCB6JDFmlyLr3/eAULq/GHLoppO6SWRBaK9dO1H/W64LEvhWvCS3yk6+yt1DFQs+IO3pgNJ6UEBBUxjNQ/6yskwEeJV1YE73BrriToXOagSrLLGPAXNrwu0OJPCuL6g9PMn9MAew7G4TEv/K5mptd+IgF0NGDDqhAIpAL4=
Message-ID: <436D509C.8050306@gmail.com>
Date: Sun, 06 Nov 2005 08:38:52 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hanselmann <linux-kernel@hansmi.ch>
CC: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
References: <20051105234938.GA18608@hansmi.ch> <436D4A36.70606@gmail.com> <20051106003019.GA19508@hansmi.ch>
In-Reply-To: <20051106003019.GA19508@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hanselmann wrote:
>> Does booting with video=xxxfb:1152x768M@60 work?  If it does, I would prefer
>> that we avoid adding more entries to the global mode database.
> 
> It boots but the picture is stretched over the display. That's what I
> first tried, too, but only adding the mode definition fixed it.

Okay.

Tony
