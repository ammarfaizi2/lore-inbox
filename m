Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSK0KDl>; Wed, 27 Nov 2002 05:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSK0KDk>; Wed, 27 Nov 2002 05:03:40 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19182 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261950AbSK0KDj>; Wed, 27 Nov 2002 05:03:39 -0500
Subject: Re: kernel bug
From: Arjan van de Ven <arjanv@redhat.com>
To: sanket rathi <sanket@linuxmail.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20021127095058.21318.qmail@linuxmail.org>
References: <20021127095058.21318.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 11:10:49 +0100
Message-Id: <1038391849.1367.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 10:50, sanket rathi wrote:
> Hi, 
> I am a writing a device driver. I have written a pci based driver for kernel 2.2.14-5.0 
> and that is working fine and now i have ported that to (with minimal changes) kernel 
> 2.4.18-14 now also it is working. in that i have to reserve memory in kernel (i send user 
> buffer address and lock (reserve) thart memory in kernel). but whenevr i start any other 
> appication simultaneously then i got some kernel messages like following  

It appears that you forgot to attach your code or to put in an URL to
it; how can anyone try to help you without it ?
