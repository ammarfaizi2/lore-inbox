Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbSJPSXf>; Wed, 16 Oct 2002 14:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbSJPSXf>; Wed, 16 Oct 2002 14:23:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10256 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262663AbSJPSXe>;
	Wed, 16 Oct 2002 14:23:34 -0400
Message-ID: <3DADB00D.80004@pobox.com>
Date: Wed, 16 Oct 2002 14:29:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: "David S. Miller" <davem@redhat.com>,
       weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
References: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de> <20021015.190019.41374479.davem@redhat.com> <20021016164057.GB85246@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:
> The other possibility is a dcookiefs (cat
> /dev/oprofile/dcookie/34343234) but that's a lot of extra
> code/complexity ...


with libfs it's pretty easy these days...

