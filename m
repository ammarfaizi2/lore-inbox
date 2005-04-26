Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVDZKQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVDZKQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVDZKN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:13:28 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:6224 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261463AbVDZKLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:11:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iEoNbbGQSq1SHdgw8oALDz+opckCTQNCQsQGLa3i7N2vAzYhyYP1dSlz/JFUPQyOrxHgWzdbq/gVNyBEuhsgtJxi9d3dnesnY7lirBguLUM6PrvZouV3tONAshZbpQ5aKAOj9r4eblUQ9rtjgOJtlyTZG3Dq86WyKr0+2ywB5ks=
Message-ID: <84144f020504260311260fa8c5@mail.gmail.com>
Date: Tue, 26 Apr 2005 13:11:30 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: "David N. Welton" <davidw@dedasys.com>
Subject: Re: rootdelay
Cc: dsd@gentoo.org, linux-kernel@vger.kernel.org
In-Reply-To: <87wtrphuvj.fsf@dedasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87wtrphuvj.fsf@dedasys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30 Mar 2005 20:05:36 +0200, David N. Welton <davidw@dedasys.com> wrote:
> I was wondering if there were any interest in my own efforts in that
> direction:
> 
> http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch

Please read Documentation/CodingStyle and follow it if you want your
patches to be reviewed (or merged).

                                     Pekka
