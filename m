Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWFKErH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWFKErH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 00:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFKErH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 00:47:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:14859 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932556AbWFKErG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 00:47:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i9oq5Y0Ch+JcdSO5N7mhGEz3Hc97PHJuGcvtOXklSgrMxK7NYZLjv7h2DxcQU76wly2Ixj+3scQAohWbsjFu78ZIh4KrqZvQxoag4XBNjb2N/yVjeBRBX2/k81Fp7egUXxTMZ32XYATlYcnk/+Bo8mcH4fyoRLL0lJJ0GINe5Ew=
Message-ID: <bda6d13a0606102147l58e7c22anbd87dcf086550bf8@mail.gmail.com>
Date: Sat, 10 Jun 2006 21:47:05 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: does linux support copy on write page table entries?
In-Reply-To: <e7aeb7c60606101829k796576e7u4247f14cdce7d791@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e7aeb7c60606101829k796576e7u4247f14cdce7d791@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Yitzchak Eidus <ieidus@gmail.com> wrote:
> does linux support copy on write page table entries?
Yes.

> and if it doesnt , how faster can it make the kernel create new process?
Mu.
