Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWJLWBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWJLWBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWJLWBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 18:01:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:10123 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWJLWBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 18:01:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OYpymGZX6fvKv4XxUh9fi9IQgUM0hNLViTButi+T9L8PQhbcsFoaBTBiFdsKXBBn0OVVETcmjuj0+lPwpmRTntkXn6XsJ5PSpw+sfXBGxsdnSXjjZ7nMwkI7W2JiTCcHtPUG/u/mHaeN2saPPeFAOXjEpY2FE922GwIxLkSizvQ=
Message-ID: <28bb77d30610121501n4c8e28b6r9c86235f7c7b4e83@mail.gmail.com>
Date: Thu, 12 Oct 2006 15:01:06 -0700
From: "Steven Truong" <midair77@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kdump/kexec/crash on vmcore file
In-Reply-To: <28bb77d30610121456t7f3738c6jf7be44ede5e59b4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <28bb77d30610121450n6cfd9c6ejd6b0370d2400a378@mail.gmail.com>
	 <28bb77d30610121456t7f3738c6jf7be44ede5e59b4e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tried to gdb the vmcore file but I got errors too.
gdb vmcore.test
GNU gdb Red Hat Linux (6.3.0.0-1.96rh)

This GDB was configured as
"x86_64-redhat-linux-gnu"..."/scratch/vmcore.test": not in executable
format: File format not recognized

Could someone here points me to the right directions or links to
troubleshoot kernel panic?

Thank you very much.
