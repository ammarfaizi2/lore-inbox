Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267670AbUH1TV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267670AbUH1TV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUH1TV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:21:28 -0400
Received: from prime.hereintown.net ([141.157.132.3]:10400 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S267659AbUH1TVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:21:03 -0400
Message-ID: <4130DB18.2020208@hereintown.net>
Date: Sat, 28 Aug 2004 19:20:56 +0000
From: Chris Meadors <clubneon@hereintown.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Lee Revell <rlrevell@joe-job.com>, Craig Milo Rogers <rogers@isi.edu>,
       QuantumG <qg@biodome.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: reverse engineering pwcx
References: <412FD751.9070604@biodome.org> <20040828012055.GL24018@isi.edu> <20040828014931.GM24018@isi.edu> <412FF888.8090307@biodome.org> <20040828033552.GN24018@isi.edu> <1093664940.8611.8.camel@krustophenia.net> <20040828122333.GC1841@ucw.cz>
In-Reply-To: <20040828122333.GC1841@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> But 160x120 sounds pretty ridiculous. It still would be possible to
> scale that to 640x480 smoothly, but the image would be obviously blurry
> and just awful even with avanced Bayer-based scaling techniques.

That sounds about right.  At 640x480 the QuickCam 3000 is an awful 
blurry mess.  Though I think the actual pixel count would be a multiple 
(divisor) of CIF, because in the nCIF resolutions it seems to expose 
more pixels.
