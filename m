Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWEAL42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWEAL42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 07:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWEAL42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 07:56:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:44140 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932068AbWEAL41 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 07:56:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j4aZrCHPniuP5EXXlqIjDzqoPepzjbbY78QIv81+urlgo/Lobua/bb2Py3fuHgXyzDZVQCaGCT1uxc2/BkgyqAgC2b7E39yiH0yu6wVpgZDzQXoJgva7Y0mhaVfI+0S8kaXRRjK6ypU1YZHOw2TYS7scl6x9+DdXPWPu3sYBNbs=
Message-ID: <6bffcb0e0605010456l7e60037cr8b05ef5bf27e5c27@mail.gmail.com>
Date: Mon, 1 May 2006 13:56:26 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: Ketchup 0.9.7 released
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060424171428.GF15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060424171428.GF15445@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

On 24/04/06, Matt Mackall <mpm@selenic.com> wrote:
> Ketchup 0.9.7 is available at:
>
>  http://selenic.com/ketchup/

Something is wrong (actual stable kernel is 2.6.16.11)
[michal@ltg01-fedora linux-stable]$ ketchup 2.6-tip
None -> 2.6.16.9
Unpacking linux-2.6.16.tar.bz2
Applying patch-2.6.16.9.bz2

[michal@ltg01-fedora linux-stable]$ ketchup 2.6.16.11
None -> 2.6.16.11
Unpacking linux-2.6.16.tar.bz2
Applying patch-2.6.16.11.bz2

Now everything looks ok.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
