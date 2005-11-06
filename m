Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVKFBjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVKFBjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVKFBjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:39:52 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:16828 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932274AbVKFBjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:39:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oHzvENhXxDJE6mo+H7T6xhphnY0yMwZKuK/pOHlN3uXB+V0Kxr0YzhWo9LiI71nwsdOql9v/CtjfTdxhayg5GNWUn9hQMA4Qak9PfsRpyzC7vAud9sVQUyC25+Xu/Fpz23Pp59xS9Jz+1MR0c6eBtKhG8Q47X0oCGHmELeX1jNQ=
Message-ID: <436D5EDC.6090107@gmail.com>
Date: Sun, 06 Nov 2005 09:39:40 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Hanselmann <linux-kernel@hansmi.ch>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
References: <20051105234938.GA18608@hansmi.ch> <1131236265.5229.49.camel@gaston> <20051106004934.GB19508@hansmi.ch>
In-Reply-To: <20051106004934.GB19508@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hanselmann wrote:
> This patch adds the framebuffer mode required for an Apple PowerBook G4
> Titanium.

Feel free to add my

Acked-by: Antonino Daplas <adaplas@pol.net>
