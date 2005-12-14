Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbVLNLqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbVLNLqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLNLqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:46:33 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:28348 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932449AbVLNLqc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:46:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jlWIU7G+LJi2aHkl7NIFZlsvG1VTYt4qcG3rF0Q6zaio3R/MgvG/zTjoaCmMxaKTyYPivOygTEnaqiBLxtHCgPoAHDYwm+ZHp0u/HeuvG5KsjROUyY1LM3UHmu/pGtigneJFLPD/ae6FlpKUXTemq5vTLN1rLyF/IF0+nbCT2Ok=
Message-ID: <1e62d1370512140346w6c0e8e69i82a23cffee3c9200@mail.gmail.com>
Date: Wed, 14 Dec 2005 16:46:30 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Prabhat Hegde <hegde.prabhat@gmail.com>
Subject: Re: querry on DMA
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7accf3e60512140324x6570a65bk319f9ff11b6e8c93@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7accf3e60512140324x6570a65bk319f9ff11b6e8c93@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Prabhat Hegde <hegde.prabhat@gmail.com> wrote:
> Hi friends,
> can any1 point me to a good linux memory management stuff. Actually i
> want to know the conversion of virtual to physical address and when u
> need to do it.

For getting detail and in-depth information on DMA and memory
management just get the book "Understanding the Linux VM" by Mel
Gorman. You can find its pdf version by just google for it. or get
from the link http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf

--
Fawad Lateef
