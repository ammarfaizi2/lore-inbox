Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWKOPYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWKOPYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWKOPYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:24:00 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:16583 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030564AbWKOPX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:23:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WzURjAf+pusTjk4y+5uMavypDtNwv6UihNxPCJSKh2PUj+mekVhtG3nZvq0tAOm4JMCb2AVHOmlzO2ktN7CuAWTiQN4kxA0MIQzjtd3ylIStuTcONvV6U1XBZUwEXXin3arTnWb3yko6/GFS2bkCOqUMMLzkwEe1EeUA/CKu8Is=
Message-ID: <e5bfff550611150723p691fc480m874cce9ad4d64476@mail.gmail.com>
Date: Wed, 15 Nov 2006 16:23:24 +0100
From: "Marco Costalba" <mcostalba@gmail.com>
To: "Andreas Ericsson" <ae@op5.se>
Subject: Re: [ANNOUNCE] qgit-1.5.3
Cc: "Git Mailing List" <git@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <45585749.5030200@op5.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
	 <45585749.5030200@op5.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/06, Andreas Ericsson <ae@op5.se> wrote:
> Marco Costalba wrote:
> >
> > Download tarball from http://www.sourceforge.net/projects/qgit
> > or directly from git public repository
> > git://git.kernel.org/pub/scm/qgit/qgit.git
> >
>
> Love the tool, but can't fetch the tag. Did you forget to
>
>         $ git push origin 1.5.3
>

I think I have pushed the new tag, indeed the gitweb interface on
kernel.org/git shows correctly the 1.5.3 tag (and also two new commits
after that).

I've also pulled from kernel.org/git/qgit in a test repository and got
the tag succesfully.

I'm not able to reproduce this, in any case I will push again the tags.

Thanks
Marco
