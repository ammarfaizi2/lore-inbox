Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263311AbUJ2NJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbUJ2NJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbUJ2NJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:09:13 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:59543 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263311AbUJ2NIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:08:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=U22ETlPVXp1MWAnj3yRm+PYoz7WTHroxJj24P2oS+oqz9T2KDskPL2DT1vGOpE0ku3qqbIH7wsu18XnP6rG0/SVLh1cY3Xf9lWFkuZrMytu5/tound09yj1O3qAfWa7qgLPUkrLr6JKdUUiYZE7IjlhyBUgDqTjvvWy8fjVqgqs=
Message-ID: <5b64f7f04102906084b358d5f@mail.gmail.com>
Date: Fri, 29 Oct 2004 09:08:49 -0400
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: best linux kernel with memory management
Cc: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041029071429.GF1246@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <412C87F3.2030602@ribosome.natur.cuni.cz>
	 <20040825114005.GB13285@logos.cnet>
	 <412C94F5.4010902@ribosome.natur.cuni.cz>
	 <20040825120450.GA22509@logos.cnet>
	 <412C9D9C.6060703@ribosome.natur.cuni.cz>
	 <20040827121905.GG32707@logos.cnet>
	 <417F6258.7010209@ribosome.natur.cuni.cz>
	 <20041028105108.GB5741@logos.cnet> <20041029071429.GF1246@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004 17:14:29 +1000, Nathan Scott <nathans@sgi.com> wrote:

> There should be no problems using XFS for everything, including
> /boot - I do that on all my systems (for a few years now).

Last time I checked (~ 2 months ago), there is a GRUB bug that
prevents the use of XFS as the /boot filesystem. I use ext3 for my
/boot to get around this, with all my other filesystems being XFS. Any
chance the XFS devs could help fix the GRUB team fix the bug?

Thanks,
Rahul
