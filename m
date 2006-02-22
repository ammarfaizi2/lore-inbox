Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161267AbWBVBtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWBVBtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWBVBtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:49:04 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:51569 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932512AbWBVBtD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:49:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YFrAZSxw6X7HAnha4vZMQJ0YAOERjP8e80BBgifhumGjQM847sIsmz5RCmVqk/LyGMbSh33UNrc7WKXgYZiypYAlFCc3HiwENb6YXX3FE6oKhNZwIypiiOsYe38DXLY/mWCoNNHGvd8T6zwL4Ia0pwCBetIZ4LDJ5zPcnEwDjoY=
Message-ID: <2c0942db0602211749o18ed19b1x53527b8411e1d8f0@mail.gmail.com>
Date: Tue, 21 Feb 2006 17:49:01 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Martin Bligh" <mbligh@mbligh.org>
Subject: Re: Mozilla Thunderbird posting instructions wanted
Cc: "Alexey Dobriyan" <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       ray-lk@madrabbit.org
In-Reply-To: <43FBBA99.7060707@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
	 <43FBBA99.7060707@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, Martin Bligh <mbligh@mbligh.org> wrote:
> http://mbligh.org/linuxdocs/Email/Clients/Thunderbird

Eek. I'd recommend using xclip [1] rather than using a mouse to cut
from emacs/whatever. ( xclip <my.diff , then paste in Thunderbird.)

   [1] http://people.debian.org/~kims/xclip/

Ray
