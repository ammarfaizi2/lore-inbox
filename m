Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUEZKCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUEZKCY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265402AbUEZKCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:02:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:35026 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S265398AbUEZKCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:02:22 -0400
Message-ID: <40B46B29.5000007@imag.fr>
Date: Wed, 26 May 2004 12:02:17 +0200
From: Raphael Jacquot <raphael.jacquot@imag.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40B43B5F.8070208@nodivisions.com>
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante wrote:
> Or, to make it more appealing, say I initially had 512MB ram and now I 
> have 1GB.  Wouldn't I much rather not use swap at all anymore, in this 
> case, on my desktop?

I do that on embedded systems. no swap. when there's no more, the 
oomkiller kicks in and removes a few extraneous processes...

> -Anthony
> http://nodivisions.com/

