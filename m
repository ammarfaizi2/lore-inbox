Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUCLJuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCLJuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:50:32 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:6794 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262062AbUCLJu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:50:26 -0500
Date: Fri, 12 Mar 2004 10:50:24 +0100
From: Romain Lievin <romain@lievin.net>
To: Anjinsan <anjinsan@skynet.be>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lufs removed from 2.6.4 kernel?
Message-ID: <20040312095024.GA29617@lievin.net>
References: <40505060.1020902@skynet.be> <20040311080906.077b9ea0.rddunlap@osdl.org> <4050A3ED.30603@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4050A3ED.30603@skynet.be>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 06:37:49PM +0100, Anjinsan wrote:
> Thanks for bringing up the patch question. It made me think, and after 
> scanning
> my 2.6.3 build directory, there it was:
> lufs-0.9.7-2.6.0-test9.patch
> 
> So I guess this explain why I didn't see it in 2.6.4. My sincere apologies.

There is no lufs in the kernel then ? Why ?
Userland capabilities are still interesting because there is no need to modify the kernel (more reliable).

Will be there anyone to merge it ?

Romain.
-- 
Romain Liévin (roms):         <romain@lievin.net>
Web site:                     http://www.lievin.net
"Linux, y'a moins bien mais c'est plus cher !"






