Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVGLBQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVGLBQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 21:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGLBQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 21:16:53 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:30471 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S261878AbVGLBQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 21:16:31 -0400
Message-ID: <42D31A06.2000608@molgaard.org>
Date: Tue, 12 Jul 2005 03:16:54 +0200
From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS/2 mouse not working
References: <42D31136.90208@molgaard.org>
In-Reply-To: <42D31136.90208@molgaard.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sune Mølgaard wrote:
> I have tried compiling psmouse as module and loading it, and I have 
> tried compiling it into kernel. I have also chosen to have a /dev/psaux, 
> that doesn't get any input either. Mouse seems to get detected, as per 
> this snippet from dmesg:

Oh yeah. I also tried an usb -> PS/2 converter on my current mouse to 
rule out a faulty mause. Same result...

/Sune

-- 
The tolerance of liberty can be maintained until complete federal and
state control by Catholics has been accomplished.
- Bishop O'Connor, Pittsburgh
