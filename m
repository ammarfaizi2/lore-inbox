Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751968AbWHNJeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbWHNJeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWHNJeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:34:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:11985 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751968AbWHNJen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:34:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rv8ftsakiq3teJc9Swo1rY3b4jctZkjiBaMS2QQ1660XPj3OJHl/wYHCJQbxRfyGpb28YTG4AwAOrkX6QL0pBUjpRXw9pjL09w9f/+AWN/mDnaJLsPfSLX0sA2H5/dl6AGRY8YSOoPTbGJJib2l6+P7vSoKTUOsYnWQ3SGbjbMM=
Message-ID: <81b0412b0608140234q28b982cau70906904461de72f@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:34:42 +0200
From: "Alex Riesen" <raa.lkml@gmail.com>
To: "Dimitri Chausson" <tri2000@gmx.net>
Subject: Re: linux troubleshooting help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060813124912.6b7b83b9.tri2000@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060813124912.6b7b83b9.tri2000@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/06, Dimitri Chausson <tri2000@gmx.net> wrote:
> 2- Running on a terminal (no X running):
> -------- output------------
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 1: ......... at ...........
> Kernel panic - not syncing: CPU context corrupt

See http://en.wikipedia.org/wiki/Machine_Check_Exception
