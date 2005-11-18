Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbVKRVOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbVKRVOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbVKRVOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:14:05 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:7951 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161246AbVKRVOE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:14:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pj9oaKSDdR/zyutwfRYnUo7KVz6vl/59PPhQIAYoPmZwX4lmQ+fnju3lNwi6uYJkNk6VkCKJDXIn8MHdQMf/Ii5sCtkKWCM0jLU+DAHQOa2rZUMxCYgSLwzbkGRJ3f++1ScwGb7sP1U5zpGlSglYQUIv1twTBRot3dREWlIOfFU=
Message-ID: <cbec11ac0511181314g7edaee33j47cbc6118228e49b@mail.gmail.com>
Date: Sat, 19 Nov 2005 10:14:03 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc1-mm1
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051118203727.GA23151@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511180743.44838.tomlins@cam.org>
	 <20051118203727.GA23151@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Greg KH <greg@kroah.com> wrote:
> Are you using debian?
> If so, what version of udev are you using?  There are some known
> reported problems with this, so I would suggest referring to the udev
> bug list.
>
In particular check the version requirements for udev - you need to be
on a version greater than or equal to 71. Sarge/stable has a really
old version. In particular I am running unstable as I had too many
funny errors (including this one) - but etch should be fine.

If running another distribution check this also as it is a real requirement.

To find the latest version of udev required check Documentation/Changes

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
