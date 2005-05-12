Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVELTvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVELTvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVELTvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:51:21 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:46719 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262031AbVELTvQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:51:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TJh+iK7kKrC+5YwJ/mLPQnLshQFO1Z4lrWDFcNVYkx2UgRfC1SiQMQiaSlOH9vKVtU0nH7Mzq7/t1puFoS1QPJIznNHSldkzKiz0wCsb2dJqKaVI8n/jwiOFqNsREgGDim6yABa9bkAwynrxxK8z1j8pXxVex7ta6UssB9IkyQE=
Message-ID: <d120d50005051212512e015286@mail.gmail.com>
Date: Thu, 12 May 2005 14:51:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alan Bryan <icemanind@yahoo.com>
Subject: Re: Enhanced Keyboard Driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050512192254.43538.qmail@web53101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050512192254.43538.qmail@web53101.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 5/12/05, Alan Bryan <icemanind@yahoo.com> wrote:
> Hi all,
> Would it be feasable to modify the current keyboard
> driver in such a way that it would log the last 1000
> keystrokes pushed (possibly log it somewhere in /proc
> or something)? When I say keystrokes, I mean
> everything...even the ctrl and alt and shift bit keys
> 
> Something like this would greatly simplify the program
> I am attempting to make.
> 

What kind of information that you need is missing if you just read
input events from /dev/input/eventX?

-- 
Dmitry
