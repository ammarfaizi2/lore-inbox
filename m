Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWITG2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWITG2I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 02:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWITG2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 02:28:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:57679 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751201AbWITG2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 02:28:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=b+jGpzx8uRV4ZOKNQoqnjtm5PuqIbmmno9NxJTJufLo6/c/S7rm4KDc0i8cnK8q0CQm1q2KP6LuoAwGdzgQHh0/IzLXrAJD0f1TZ7bwpPfCIimwZCLXs+afAGkY14OFgXeAtySLyPnu3ig7Jx3E+h8MlsResGy99IaFJcrtiGto=
Message-ID: <84144f020609192328k4a2b2a70w5b068f49649398d6@mail.gmail.com>
Date: Wed, 20 Sep 2006 09:28:05 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
Cc: "Alex Dubov" <oakad@yahoo.com>, linux-kernel@vger.kernel.org,
       drzeus-list@drzeus.cx, rmk+lkml@arm.linux.org.uk
In-Reply-To: <20060919232016.68a02e0e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com>
	 <20060919232016.68a02e0e.akpm@osdl.org>
X-Google-Sender-Auth: d28722cb9fdcaaba
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
> Trivia:

[snip]

More trivia:

  - Unnecessary casts for void pointers
  - Assignment in if statement expression
