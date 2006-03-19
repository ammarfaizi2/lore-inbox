Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCSDKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCSDKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 22:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWCSDKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 22:10:54 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:39365 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbWCSDKx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 22:10:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mzpe06WsO7iDXnUNEU8FBJUoVQ17hgxoV+XyPQ5H9VT+Uy0NIOgw+2BfHE3FM2sRWhB5N9AzhJzpQ37f1GoFIm5uwNGNo7pnymORCBpQC/KD/ZHv03OGMyoZCdg0Wo4FiY9x4HeFZW5ncjcxdjR0hC46hJOc/nh/46afR7NFJ0U=
Message-ID: <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com>
Date: Sat, 18 Mar 2006 22:10:43 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wu Fengguang" <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060319023413.305977000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060319023413.305977000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is probably a readahead problem. The lighttpd people that are
encountering this problem are not regular lkml readers.

http://bugzilla.kernel.org/show_bug.cgi?id=5949

--
Jon Smirl
jonsmirl@gmail.com
