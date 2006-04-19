Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWDSRnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWDSRnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWDSRnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:43:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:22983 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751013AbWDSRnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:43:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V1x3v/hgqsbjWE2yNnihY2sBtySt0ErOp8TSPS7zGNLCLyri74hlC70I9L9670d7EIDjDzg6XSQyQRI/xjldSop51ctnZfXrRWMTjNc3nE0xRBIeJQhrbMqDDYqKk0e/7xtbrghpyNDU8AmZiCtTKqcsH+CPEh5/KknImsD+834=
Message-ID: <84144f020604191043s5da78a69m8207b8145989eb62@mail.gmail.com>
Date: Wed, 19 Apr 2006 20:43:05 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Thiago Galesi" <thiagogalesi@gmail.com>
Subject: Re: Possible MTD bug in 2.6.15
Cc: "Jim Ramsay" <kernel@jimramsay.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <82ecf08e0604191006r26d8eab0n2c0a425809dea6ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e0604190949t42677b35mcba4ee57b92ffff9@mail.gmail.com>
	 <82ecf08e0604191006r26d8eab0n2c0a425809dea6ac@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Thiago Galesi <thiagogalesi@gmail.com> wrote:
> Ok, a couple of comments/questions
>
> 1 - Wouldn't it be better to map all flash, and leave the unneeded
> part as read only?
>
> 2 - Please follow  Documentation/SubmittingPatches format for sending
> patches (especially the signed-off part and sending patches inline)
>
> 3 - No C++ style comments, please

4 - Read Documentation/CodingStyle before resubmitting the patch.

                                     Pekka
