Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVHFKno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVHFKno (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVHFKno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 06:43:44 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:10419 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262116AbVHFKnn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 06:43:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXq4Vl6IcKq2y5z6BTJ8bQj8HZ9y68gG0UvUQ2ZomNOsXSuTSre1+jBzBm5Hc4Po+nFaNMwQDW9/zR8FDNZDPXzKr8O+49aFlnjNQ/oHa4c3Oj7Ln83vxN6nnga8Lj1SQoJV5uJXZMPQK2n+pcfBDqnFt5hgPzMwc2ugFUZFZjo=
Message-ID: <9a874849050806034360978b8d@mail.gmail.com>
Date: Sat, 6 Aug 2005 12:43:43 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Simon Morgan <sjmorgan@gmail.com>
Subject: Re: Outdated Sangoma Drivers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <de63970c05080602496c2c8b11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <de63970c05080602496c2c8b11@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/05, Simon Morgan <sjmorgan@gmail.com> wrote:
> Hi,
> 
> I couldn't help noticing that the Sangoma drivers distributed with the
> current kernel are slightly out of date and was wondering whether there
> was any reason for this?
> 
Probably nobody has taken the time to do a diff between the kernel's
current version and the the one distributed by sangoma.

If someone (hint hint) was to do a diff, clean it up to ensure it
matches kernel CodingStyle and standards and then send it in along
with a description of the changes made and why they make sense, what
bugs it fixes etc, then that person could probably get such a diff
merged.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
