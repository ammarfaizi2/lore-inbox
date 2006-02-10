Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWBJWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWBJWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWBJWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:01:25 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:11722 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932208AbWBJWBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:01:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SwyUYtGQGHSVf0zG3XFdjIw56LVxtlJVgJtLEJDP/FusBwZ2pUQtDZJYwNcbrIh9pfDr7Q4AAvvgE7DjLOsdwJXSLCi16o9h+kU0GMALgQWQfHGInW+uKQoPpElpFqstIimsxTKtN3AeEYRQVFcxRj85yNZgogGLgNkLa6sDO7A=
Message-ID: <43ED0D3C.1020702@gmail.com>
Date: Sat, 11 Feb 2006 06:01:32 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ivan Matveich <ivan.matveich@gmail.com>
CC: linux-kernel@vger.kernel.org, adaplas@pol.net, torvalds@osdl.org
Subject: Re: [patch/trivial] nvidiafb: detect GeForce4 MX 4000 AGP 8x
References: <b5def3a40602101150w52bc1c66v6307d45a00a15c36@mail.gmail.com>
In-Reply-To: <b5def3a40602101150w52bc1c66v6307d45a00a15c36@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Matveich wrote:
> This patch makes nvidiafb detect my video card; it seems to work fine.
> 

Thanks.  The exact same patch was already submitted to Andrew.

Tony
