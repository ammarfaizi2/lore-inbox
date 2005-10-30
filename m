Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbVJ3MxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbVJ3MxB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJ3MxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:53:01 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:4323 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751025AbVJ3MxB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:53:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S0zl0GOwMZK3IyZNFstBU7hvFAXfYAGMRRxPX5PSIwkKcs9OpuYCFCXtydktL/D6Bnes5uDOYfY/v1gy7oaCA1K7qIGaNzE/f2nprfJwJGWfJ1A+gQ04RYVOW5YqOgz+9XtzhZRLeT22sspVjyogCkPL5Jb/tzDBHrZYvC8bsQ4=
Message-ID: <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
Date: Sun, 30 Oct 2005 12:53:00 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Rob Landley <rob@landley.net>
Subject: Re: What's wrong with tmpfs?
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <200510300624.38794.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510300624.38794.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/05, Rob Landley <rob@landley.net> wrote:

> If somebody needs a reproduction sequence, I'm happy to oblige.  In theory
> "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it
> wouldn't have shipped...

I don't see this behaviour on a regular desktop box running 2.6.14.
Guess it's UML specific.

Jon.
