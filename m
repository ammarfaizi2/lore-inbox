Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVCQSYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVCQSYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVCQSYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:24:35 -0500
Received: from gandalf.light-speed.de ([82.165.28.152]:28127 "EHLO
	gandalf.light-speed.de") by vger.kernel.org with ESMTP
	id S261992AbVCQSYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:24:34 -0500
Message-ID: <4239CB59.8020805@light-speed.de>
Date: Thu, 17 Mar 2005 19:24:25 +0100
From: Jens Langner <Jens.Langner@light-speed.de>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20050206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11.4 1/1] fs: new filesystem implementation VXEXT1.0
References: <42399F54.1010108@light-speed.de> <20050317182048.GA16328@mars.ravnborg.org>
In-Reply-To: <20050317182048.GA16328@mars.ravnborg.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

>>The following URL is link to a large patch for a possible integration of 
>>a new filesystem implementation in the misc section of the kernel tree. 
> 
> If you like people to review it te best thing to do is to break it up
> in smaller logical selfcontained pieces (not just file-by-file) and post
> these. People on this mailing list seldom follow URL's.

Sorry, but as the patch is a complete new implementation the patch file 
is almost 110KB long. So I thought it might be a better idea to just 
post an URL.
Also the "Documentation/SubmittingPatches" file in the kernel tree does 
suggest to just post an URL if the files are too large. And IMHO 110KB 
is quite large, isn't it? ;)
But if someone wants me to submitt the whole patchfile, I can of course 
do so.

cheers,
jens
-- 
Jens Langner                                         Ph: +49-351-4716545
Lannerstrasse 1
01219 Dresden                                Jens.Langner@light-speed.de
Germany                                      http://www.jens-langner.de/
