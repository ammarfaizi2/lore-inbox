Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVIIVx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVIIVx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVIIVx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:53:57 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:43351 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030355AbVIIVx4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:53:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qReYqUc2cz7kY+f3aZ1g8fDMYS776+AlOgQle5OCcxDQR1iPUjADIpeIZjZraLUL5da10jfTXuW1MxMYHniUBXkquHI/EdnRAu4p9iPuedvuPdZEbLgtV9xY4g0Kk/N64ZZJHlljJKkSIYRkz1J2dpPyDOWI4Mg9e9pjI7kzs8w=
Message-ID: <6bffcb0e0509091453117d9978@mail.gmail.com>
Date: Fri, 9 Sep 2005 23:53:53 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: testing a kernel - how can i help?
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050909204313.GA26469@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050909204313.GA26469@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/09/05, Folkert van Heusden <folkert@vanheusden.com> wrote:
> Running klive on a sparc.
> Now I wonder: what should/can I run to help by testing a kernel? The sun
> is dedicated for the testing so everything is possible.
> 
> 
> Folkert van Heusden
> 

You have at least 2 ways:
1 - test less bleeding edge -git and -rc, but it's hard, every day job :).
2 - test -mm - front line.

Regression tests? You can test every plugsched release or other useful thing.

Regards,
Michal Piotrowski

ps. My klive host: 6ce68650da42a5188df54b6989e153e0
ps.2 Sorry for my horrible English
