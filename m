Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWAFNJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWAFNJH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 08:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWAFNJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 08:09:07 -0500
Received: from quark.didntduck.org ([69.55.226.66]:37582 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1750850AbWAFNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 08:09:06 -0500
Message-ID: <43BE6C44.6040504@didntduck.org>
Date: Fri, 06 Jan 2006 08:10:28 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: .gitignore files really necessary?
References: <20060106022531.GA7152@localhost.localdomain> <43BDE71D.3000103@didntduck.org> <20060106055845.GA12015@localhost.localdomain>
In-Reply-To: <20060106055845.GA12015@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> On Thu, Jan 05, 2006 at 10:42:21PM -0500, Brian Gerst wrote:
>> Coywolf Qi Hunt wrote:
>>> Hello,
>>>
>>> I see you keep updating .gitignore files. That would be a never ending
>>> extra burden IMHO.  May I suggest we all use KBUILD_OUTPUT instead to keep
>>> the source tree clean?  Or am I missing you?
>>>
>>> 	Coywolf
>> Seperate output dirs are nice for building release kernels, but for
>> doing development it makes things more difficult.  The .gitignore files
> 
> How? An example? I think it firstly benefits development, like making diffs.

Making diffs is what git is for.

--
				Brian Gerst
