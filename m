Return-Path: <linux-kernel-owner+w=401wt.eu-S1754816AbWLVLfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816AbWLVLfd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 06:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbWLVLfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 06:35:33 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:27593 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbWLVLfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 06:35:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PWSKanG+2qhzcf5NZsIOyyFz++88EKpfoFMymfCDGLWzmTy5owzfM9HekItRDjwK4WjejGVxdWbOAHFiwDp8MTGGbyHzMxUHLhRNq2VAQBIyeT5HF9zc6q7eWOlWAz2w92WrD8WsbaR2axE2o41gcukMGptipk7UOAdR+V0tMX0=
Message-ID: <3a5b1be00612220335l4779089egae0d3270a7c9cd5f@mail.gmail.com>
Date: Fri, 22 Dec 2006 13:35:31 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: omap compilation fixes
Cc: "Tony Lindgren" <tony@atomide.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       "Vladimir Ananiev" <vovan888@gmail.com>
In-Reply-To: <20061222105521.GA23683@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061222105521.GA23683@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> This is not yet complete set. set_map() is missing in latest kernels.
>
> Fix DECLARE_WORK()-change-related compilation problems. Please apply,
>
> Signed-off-by: Pavel Machek <pavel@suse.cz>
>

Please check linux-omap-open-source mailing list. Some of the build
breakage patches are already posted regarding to latest kernel sync
up.

http://linux.omap.com/pipermail/linux-omap-open-source

-- 
---Komal Shah
http://komalshah.blogspot.com
