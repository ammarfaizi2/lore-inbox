Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVCWTu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVCWTu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVCWTuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:50:55 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:6387 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262857AbVCWTut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:50:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HIz8YOTfqrd282kMdfOXSMQAFMLiK9YwvWNmk7cs5rlV20s299PZ7/cGDlBWtmk+6zBI1hnWd314dxtIpj0l2vovea6c/2FJLWb22wScOuaO4Q5BrWs75PCQ7dE1g9I95E5+K7zUgutETzV/afoVyZ9M3qtQQD9zcuY3IiHa54c=
Message-ID: <21d7e9970503231150263cfc5e@mail.gmail.com>
Date: Thu, 24 Mar 2005 06:50:49 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: X not working with Radeon 9200 under 2.6.11
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, airlied@linux.ie
In-Reply-To: <20050321162214.71483708.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <16937.54786.986183.491118@ccs.covici.com>
	 <20050321145301.3511c097.akpm@osdl.org>
	 <16959.25374.535872.507486@ccs.covici.com>
	 <20050321162214.71483708.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> It's a bit sad that xfree _used_ to work (2.6.9?) and now it doesn't work,
> and the fix is to switch to the x.org server.
> 
> Do we know what changed to cause this?  Was it deliberate?

If I was a guessing man and I am due to lack of time.. I'd say the
address space layout changes .. I doubt the macro removal patches
could have done anything that bad.. I suppose I could go and
re-install Fedora Core 1 somewhere...

Dave.
