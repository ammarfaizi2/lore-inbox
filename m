Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVAQW0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVAQW0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVAQWZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:25:28 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:7306 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262905AbVAQWNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:13:02 -0500
Date: Mon, 17 Jan 2005 23:13:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050117221331.GC17132@mars.ravnborg.org>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC363D.1090106@zytor.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:03:41PM -0800, H. Peter Anvin wrote:
> I don't mind the current default, but saying I shouldn't be able to 
> override it is asinine.
No-one asked for it until now.
Any preferred syntax to disable this dependency check?

> 
> It also means "make install" is largely unusable.

Maybe we should not let install be dependent on vmlinux then?

	Sam
