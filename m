Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWCUIdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWCUIdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWCUIdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:33:00 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:25977 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbWCUIdA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:33:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mfS5ctsC9eKQNBq6FmwA7rcvHimA+FxYnzD9Q+fqDoD8dlIBLF+B0OChHosaL522KbhhxkKR/obH4Dg7j18AS/CqZVdK54as7t6yGYc1UXGEVgFGnEAkMfaNktBIGugd69jF3IPJjsxo4Xoqsj+XmkUZp4RgAwFXH8aRrgXpsUE=
Message-ID: <9597aec10603210032q273f9015wc9ad5cf70ee1be6b@mail.gmail.com>
Date: Tue, 21 Mar 2006 03:32:38 -0500
From: "ragin shah" <shahragin1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: "Low-latecny patch for ARM"
In-Reply-To: <9597aec10603200258k59b08f7ex2b8b307d4d000c2f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9597aec10603200258k59b08f7ex2b8b307d4d000c2f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
I m student.
I want to apply low-latency patch to kernel 2.4.26  for ARM processor.
I applied Andrew Morton's low latency patch of 2.4.25kernel to 2.4.26
kernel. I made some changes for '.config' section  to apply it
correctly to ARM. Can anybody tell me whether i m right or wrong ? It
is not giving any error while applying patch.
Second thing,
Can anybody please tell me how to measure scheduler latency for kernel
on ARM after applying low-latency patch to measure kernel's
responsiveness?
Thanks in advance!

On 3/20/06, ragin shah <shahragin1@gmail.com> wrote:
> Hi !
> I m student.
> I want to apply low-latency patch to kernel 2.4.26  for ARM processor.
> I applied Andrew Morton's low latency patch of 2.4.25kernel to 2.4.26
> kernel. I made some changes for '.config' section  to apply it
> correctly to ARM. Can anybody tell me whether i m right or wrong ? It
> is not giving any error while applying patch.
> Second thing,
> Can anybody please tell me how to measure scheduler latency for kernel
> on ARM after applying low-latency patch to measure kernel's
> responsiveness?
> Thanks in advance!
>
