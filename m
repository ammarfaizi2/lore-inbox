Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFVN0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFVN0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 09:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVFVN0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 09:26:44 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:55357 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261203AbVFVN0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 09:26:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DnmLVuPIjl11avs963oqW73ka6VyDPwJHXPz3HpThFyZ4+wap2vyJIhKmc21GMLdDzMDh3ftA5GjVRFM17bM+A2Q9j28TIaMNOVCpb75F810L6+Sbfg4dMTXdCQXHU2W+gztPJp4rSQ0IZKibNhjEB57k1vfAqfihGVQmXFsYCI=
Message-ID: <a4e6962a05062206262190276b@mail.gmail.com>
Date: Wed, 22 Jun 2005 08:26:40 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [CORRECTION] [-mm PATCH] v9fs: Clean-up vfs_inode and setattr functions
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <200506220125.j5M1P1Rh022077@ms-smtp-05-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506220125.j5M1P1Rh022077@ms-smtp-05-eri0.texas.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, ericvh@gmail.com <ericvh@gmail.com> wrote:
> Cleanup code in v9fs vfs_inode as suggested by Alexy Dobriyan.

Make that Alexey Dobriyan.

> Did some major revamping of the v9fs setattr code to remove unnecessary
> allocations and clean up some dead-code.
> 
> Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>
> 

[patch contents remain the same]

            -eric
