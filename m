Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVLTVly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVLTVly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVLTVly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:41:54 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:32161 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932138AbVLTVlx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:41:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DbXiRtI8eD8MoHQdLe/cID3GGMK0pCN7zD2ROh7ucvjAG6ReiLJJ6iH71C6mJFd9CbLs9ipwbKq5axKtoK8p65CuqbNQqYA9/1Ik2FS98P/BlOzrDJc6NHy+zvGbnc8oQiYBuysUoUMO55XTvSndJ8trh3jITtari5VWMGbvvxE=
Message-ID: <cbec11ac0512201341v520bbcads6d16624f1a8ca739@mail.gmail.com>
Date: Wed, 21 Dec 2005 10:41:52 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Update to SubmittingPatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7vlkygo2q9.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cbec11ac0512191831j563ea167vc5a63e11a34c7ef9@mail.gmail.com>
	 <7vlkygo2q9.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Use of git-diff
> >
> > Signed-off-by: Ian McDonald <imcdnzl@gmail.com>
> > ---
> > +You can use git-diff which makes your life easy....
>
> Even easier might be to suggest git-format-patch(1).
>
>
Yes git-format-patch looks easier if doing full git development. If
just working on one bug fix git-diff is probably easier. I'll
reference both and resubmit.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
