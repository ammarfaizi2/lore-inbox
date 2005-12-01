Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVLANtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLANtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVLANtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:49:24 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:24086 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932239AbVLANtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:49:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Sntr7J+aZ54ipoZiY7KErftWi9iRjxU64BM9GdrFwmrGLu6gdErc9hsIX1E2+P3HfZd1myuSfPknqILaWime+ilz4immFn64xVgSE/qw4BWx++lcf6Gf4bGxJ/mopayBF5YhEuvYTPXcfpmjR3WyTuEzubAOQC/kPnBz9aSuSco=
Message-ID: <438EFF5D.5080801@gmail.com>
Date: Thu, 01 Dec 2005 22:49:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 00/11] blk: reimplementation
 of I/O barrier
References: <20051124162449.209CADD5@htj.dyndns.org>
In-Reply-To: <20051124162449.209CADD5@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, the following patches can go into post-2.6.15 & -mm.

#01 - #08
#11

Thanks.

-- 
tejun
