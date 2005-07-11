Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVGKVvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVGKVvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVGKVtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:49:15 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:1752 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262654AbVGKVsd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:48:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J8wG0CS7he2sQNsmJng5BrVD4v+8o8Cr5m8RthEHBsdgvi+AJwNGgtCNE+LKhqB6w1Njpc+LZ74TbJID4JvCeD0d7befMWfc9mlRAcgCS5UuWCsAzZ7h5ueKn4pAlGIDwajQk86Bo21zMvam09A0GOi5ASBVf3CTmV1cdl+UtK4=
Message-ID: <d4dc44d5050711144733422f4b@mail.gmail.com>
Date: Mon, 11 Jul 2005 23:47:44 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: kernel.org COPYING file not current?
Cc: linux-kernel@vger.kernel.org, ftpadmin@kernel.org
In-Reply-To: <42D2E585.6080307@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D2E585.6080307@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/05, Chris Friesen <cfriesen@nortel.com> wrote:
> I was putting together a small webpage and wanted to link to the COPYING
> file for the linux kernel.
> 
> I found the one at http://www.kernel.org/pub/linux/kernel/COPYING (also
> at ftp://ftp.kernel.org/pub/linux/kernel/COPYING), but when I compared
> it with the latest version in 2.6.12.2, there were some differences.
> 
> It would be convenient to have a web-accessable up-to-date version of
> this file.  Any chance of getting it updated?

You could link to the latest version in Linus' git repository:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;h=2a7e338ec2fc6aac461a11fe8049799e65639166;hb=1604d9c8f8dffafe3a077dc5ae7c935d2318bcf6;f=COPYING

That's a link to a specific revision, though, and I'm not sure if you
can just link to the latest version of the file. Somebody else with
more experience regarding git's web front-end may be able to tell you
more.


-- 
schnee
