Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWELGTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWELGTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWELGTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:19:25 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:1015 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750993AbWELGTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:19:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZIvmhs6JrlZNdWNz2028EobSNcng8vEI9LWKW8ZhEIRqc/W5HUXfIaFhv1eURHTJ4TBpzPj1Zm2Xgyb0c5Qx0D1e7MOOIaBSSZQet9Bu2jLPTJYOWuoPJr8R369o2pnBlOEYFbF+9GgJeoYRGKYfvfJrCMvCrL5PKX+n5c+fV/4=
Message-ID: <bda6d13a0605112319i69585926v6f77bfa77c450a51@mail.gmail.com>
Date: Thu, 11 May 2006 23:19:24 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4 mucked .config
In-Reply-To: <20060512054339.GG11191@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0605112102m70b20772y946d149b6f8bd56@mail.gmail.com>
	 <20060512054339.GG11191@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Why did not you do "make oldconfig" in the first place ? This is the
> only way to migrate your .config from one kernel to another, as it
> will ask questions only for unknown (=new) values.
>
> Willy

Because on some previous version it asked every question in Kconfig so
I assumed that is what it is supposed to do.

Might as well chalk this one up to PEBKAC
