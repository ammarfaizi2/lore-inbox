Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423572AbWJaQe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423572AbWJaQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423578AbWJaQeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:34:25 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:8314 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423574AbWJaQeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:34:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=shCn/sOhQxyt8Aa7IRZkXWSFDLMkhxtogQNkgbbpqzkExbl2/Ki3drWOuj6Bs9FBIljGbSnbDECBu0339zN/eeqG+ofORMR6BYX6Z8nX+1GubdV3VIB3NjpjjXA6qN+IyIgQVnhxhxltcuGo7fhCdVGpboA4+6d7T8+3FdJvenU=
Message-ID: <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com>
Date: Tue, 31 Oct 2006 08:34:23 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: Linux 2.6.19-rc4
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
In-Reply-To: <45477668.4070801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	 <20061030213454.8266fcb6.akpm@osdl.org>
	 <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
	 <45477668.4070801@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Martin J. Bligh <mbligh@google.com> wrote:
> > At some point we should get rid of all the "politeness" warnings, just
> > because they can end up hiding the _real_ ones.
>
> Yay! Couldn't agree more. Does this mean you'll take patches for all the
> uninitialized variable crap from gcc 4.x ?

What would be useful in the short term is a tool that shows only the
new warnings that didn't exist in the last point release.

Ray
