Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWEZRMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEZRMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWEZRMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:12:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:40912 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751166AbWEZRMe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VotOANv3ziIss5nmpcK5Ir244eRe9pjXeXe/IhgJP3scQEav9/Y2jAIRhVD+DAUqWkCkaSOqyY/vKf34zIUlLUxUWhL+CVFhd6aYp4sIhFqeJ1SxbefO4k+TiObFzgl+iAzdrT3T0qyIyRWcdWZOU06uJw3bFJFScLMOtRlSCeM=
Message-ID: <9e4733910605261012w1d470b11rbf120d5c0d0d1750@mail.gmail.com>
Date: Fri, 26 May 2006 13:12:09 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel design: support for multiple local users
In-Reply-To: <20060526163125.GI16521@fooishbar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910605260901h6452c795s1c40cf61b47fc69a@mail.gmail.com>
	 <20060526163125.GI16521@fooishbar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Daniel Stone <daniel@fooishbar.org> wrote:
> On Fri, May 26, 2006 at 12:01:15PM -0400, Jon Smirl wrote:
> > It is possible to set the current X server up to support this
> > configuration. Using the X server this way has some drawbacks. The X
> > server needs to be run as root.
>
> So far, so good.
>
> > The multiple users are sharing a
> > single X server image so things they do can impact the other users.
>
> No, they're not.

So if I manage to fault my X server process, they other users a just fine?


-- 
Jon Smirl
jonsmirl@gmail.com
