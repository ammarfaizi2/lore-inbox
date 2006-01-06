Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWAFF6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWAFF6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 00:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbWAFF6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 00:58:53 -0500
Received: from [218.25.172.144] ([218.25.172.144]:25095 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751409AbWAFF6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 00:58:52 -0500
Date: Fri, 6 Jan 2006 13:58:45 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: .gitignore files really necessary?
Message-ID: <20060106055845.GA12015@localhost.localdomain>
References: <20060106022531.GA7152@localhost.localdomain> <43BDE71D.3000103@didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDE71D.3000103@didntduck.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 10:42:21PM -0500, Brian Gerst wrote:
> Coywolf Qi Hunt wrote:
> > Hello,
> > 
> > I see you keep updating .gitignore files. That would be a never ending
> > extra burden IMHO.  May I suggest we all use KBUILD_OUTPUT instead to keep
> > the source tree clean?  Or am I missing you?
> > 
> > 	Coywolf
> 
> Seperate output dirs are nice for building release kernels, but for
> doing development it makes things more difficult.  The .gitignore files

How? An example? I think it firstly benefits development, like making diffs.

> don't affect the actual build, so it doesn't matter much if they arent't
> totally kept up to date.

But someone has to maintain them.

	Coywolf
