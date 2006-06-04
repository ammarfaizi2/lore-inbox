Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751152AbWFDJcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWFDJcR (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWFDJcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:32:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:28031 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751197AbWFDJcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:32:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J31FZYjVxt8kEk2sy7/KzuuW64ivYxyxZvEo7bSaKfS9WnySFDNln+5BvRs3evuvFXOIg5hjBfIqhu6PONTC/Jl68dK9XQ7UwDGOU/pdFHY1wbosnihHQqTWItc44r7Lr2qMzO4AEdjiOqVK5pfo7YB6Aty4AvAD3ozGkvNuo+o=
Message-ID: <e5bfff550606040232yffdba0ax43b1b891dfdc5b5e@mail.gmail.com>
Date: Sun, 4 Jun 2006 11:32:15 +0200
From: "Marco Costalba" <mcostalba@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [ANNOUNCE qgit-1.3]
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <e5u8fk$ju6$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e5bfff550606040155v14565312na26f8c866f0fc32d@mail.gmail.com>
	 <e5u8fk$ju6$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Marco Costalba wrote:
>
> > This is qgit-1.3
> [...]
> > NEW IN THIS RELEASE
> >
> > Main focus of this release is usability.
> >
> > The big feature is the use of tabs instead of independent windows.
> >
> > This change alone could be enough for a release. It's a big rewrite of UI
> > code to let browsing revisions and patches quicker and easier.
>
> Of course that is advantage _only_ if the tabs are independend, and one
> (usually) doesn't need to view them simultaneously, e.g. side by side.
>

Actually they are.
One for revisions list, one for patches and one for file content.
File content tab is indipendent from previous two (of course it can be
synced on request).

> Just my 3 eurocents ;-)

Well, at today exchange rate should be 'my 2.3 eurocents'  :-)


      Marco
