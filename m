Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWAZUsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWAZUsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWAZUsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 15:48:38 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:30684 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964883AbWAZUsh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 15:48:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U158Wq3q2uqHNsb465CkeWvjkxxAFIW2qPGLZZCxYDH+KKsy+Qs186ov4sn6fnsyzUhywmvQESKd/bmdO1y4ZtF0nIq1lVHOZXnmXVDHh6wMo6lw3jonQOKqaSm+Ey5Y+LdiqqaiWDVGIg/ch2S3wSZxhu4pnSafJ2Ydw7NlNfo=
Message-ID: <de63970c0601261248pd47e7bav@mail.gmail.com>
Date: Thu, 26 Jan 2006 20:48:37 +0000
From: Simon Morgan <sjmorgan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Asus P5A Reboots
In-Reply-To: <1138308128.2976.109.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <de63970c0601261240i1770324ek@mail.gmail.com>
	 <1138308128.2976.109.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/06, Arjan van de Ven <arjan@infradead.org> wrote:
> you most likely are getting an i686 kernel, while the cpu you have is an
> AMD K6 which doesn't support the cmov instruction as used in i686
> kernels...

You're completely right. I'm an idiot. Thanks for your help.

Simon
