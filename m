Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVBWMYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVBWMYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 07:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVBWMYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 07:24:45 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:7403 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261478AbVBWMYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 07:24:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qUMUfA6GWfg0vhoegxAVcte500TGlHgtc+bfuquY4/ZhQFHhMxU6y0CrCA9DxU5z84N0q25+hDuG5Yp7aaajZdA8v6Ij9oe/iNWP8Ez8l5m5+Qh/szE9VSBaKMd02WjIGSVGckabXTDTNvGEELZdio4UzjlbnkyJiF+FUffkejI=
Message-ID: <d14685de05022304243754a9ea@mail.gmail.com>
Date: Wed, 23 Feb 2005 13:24:40 +0100
From: sylvanino b <sylvanino@gmail.com>
Reply-To: sylvanino b <sylvanino@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: I wrote a kernel tool for monitoring / web page
In-Reply-To: <d14685de050218164127828b06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <d14685de050218164127828b06@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote a kernel tool for my personnal usage which goal is to keep a
record of recent task preemptions and interruptions that appears under
linux. Either for debugging through KDB, or for monitoring/analyze
with a   graphics representation.

as adviced, SourceForge project is now opened:
http://sourceforge.net/projects/kernelanalyzer/

Best regards,

Sylvain
