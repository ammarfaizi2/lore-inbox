Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSBMVFE>; Wed, 13 Feb 2002 16:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288949AbSBMVEy>; Wed, 13 Feb 2002 16:04:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5385 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288936AbSBMVEm>; Wed, 13 Feb 2002 16:04:42 -0500
Message-ID: <3C6AD4DC.8010802@zytor.com>
Date: Wed, 13 Feb 2002 13:04:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: /proc key naming consistency
In-Reply-To: <20020213030047.8B1FB2257B@www.webservicesolutions.com> <a4eh19$lko$1@cesium.transmeta.com> <E16b6OL-0002Q8-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
> What do you think about the idea earlier in this thread of going with 
> shell-parsable key value pairs?  I find that idea really attractive, but 
> there's the issue of breaking utilities (kde control panel?) that already 
> parse the existing format.
> 


I like the idea.  Unfortunately I think it's more than kde that's going to
break.

	-hpa




