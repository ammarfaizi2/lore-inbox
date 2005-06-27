Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVF0R60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVF0R60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVF0R60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 13:58:26 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:55088 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261399AbVF0R6Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 13:58:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d7YtcEfD1k8ss8/yoZDMuYW6OpcDmOxaen0XStPOjlrz/AxO422eRPnCFkR9Q70kXWZFNYV1iQtL4l2ZCVLm2YwMK0cL00ktZIpUeNXb0KEWa7WbHEUso9F9lpR+gF+O5WVaXnc1q2IYWyFWh3PdSVIO95XGM/5ATidYr+bB6ZI=
Message-ID: <84144f0205062710582ca366c0@mail.gmail.com>
Date: Mon, 27 Jun 2005 20:58:23 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Subject: Re: Documentation about the Virtual File-System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4fec73ca05062710082e273097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <4fec73ca05062710082e273097@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/05, Guillermo López Alejos <glalejos@gmail.com> wrote:
> Is there any "Building a File system HOWTO"?

I am not aware of such document but take a look at fs/ramfs/inode.c.
It is a simple memory-based filesystem and sort of a tutorial to the
VFS.

                               Pekka
