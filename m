Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVE1KOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVE1KOA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 06:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVE1KN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 06:13:59 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:14733 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262464AbVE1KN6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 06:13:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eKU4QkSYLki97advQITod6Q7hDKK8SOiKYgtpIkxFdHtHnBM1v7OdnL37rMOFkr87ClVOPoqtsT2a309lbhoX9oyivo33RIEuQ+y2SwFa9nS3dmmz8dtQZ4jvaAqIEfK9J8WksdNmdJIsq69f6ooEv534+0ii7b/kA3l4TRYkf4=
Message-ID: <493984f05052803133dee470c@mail.gmail.com>
Date: Sat, 28 May 2005 12:13:57 +0200
From: Christian Henz <christian.henz@gmail.com>
Reply-To: Christian Henz <christian.henz@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-mm2 + Radeon crash
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
In-Reply-To: <20050525154123.2468b396.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <493984f050309121212541d8@mail.gmail.com>
	 <20050525154123.2468b396.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/05, Andrew Morton <akpm@osdl.org> wrote:
> Christian Henz <christian.henz@gmail.com> wrote:
> >
> > Hi,
> >
> > I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
> > I've run into a severe
> > problem.
> 
> Christian, can you please retest 2.6.12-rc5?
> 

2.6.12-rc5 and -mm1 seem to work fine!

Thanks :-)

cheers,
Christian
