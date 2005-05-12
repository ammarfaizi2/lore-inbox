Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVELDDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVELDDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 23:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVELDDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 23:03:34 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:14227 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261313AbVELDDV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 23:03:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h+WvSIEuzcWGvrroyA227ywYdW4Nqdrog7tHKIAHgiS+/hlSFdY/aJ8jI1UHbtyqDKD0AOEeAIQL8mUl5PEaQ4cRq0M3Fuy2CRZbPhYynM4wxJkLXQIw6PZ4l+5yBgh2tGqwSkOs7P+1dGaFSvA6SxOcZ5muK/ocNxVlwA1wsb0=
Message-ID: <957e58a9050511200324852e11@mail.gmail.com>
Date: Wed, 11 May 2005 20:03:21 -0700
From: Randy Dunlap <randy.dunlap@gmail.com>
Reply-To: Randy Dunlap <randy.dunlap@gmail.com>
To: "ndnguyen3@comcast.net" <ndnguyen3@comcast.net>
Subject: Re: usb keyboard for kdb in 2.6
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <051220050246.3184.4282C38D000B0D9500000C702206999735CC020A979A09020B02@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <051220050246.3184.4282C38D000B0D9500000C702206999735CC020A979A09020B02@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/05, ndnguyen3@comcast.net <ndnguyen3@comcast.net> wrote:
> Hello,
> 
> Does anyone happen to know when/if support for usb keyboard in kdb will be added back into kernel 2.6? Many thanks.

Don't know for sure, but it seems as though work on it has stopped.

You could try the kdb mailing list:  kdb@oss.sgi.com
(archives are here:  http://oss.sgi.com/archives/kdb/ )

and see this thread:
http://oss.sgi.com/archives/kdb/2005-01/msg00004.html

-- 
~Randy
