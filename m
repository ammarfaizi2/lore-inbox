Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965419AbWKGQ75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965419AbWKGQ75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965545AbWKGQ75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:59:57 -0500
Received: from wr-out-0506.google.com ([64.233.184.234]:40788 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965419AbWKGQ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:59:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bXAHvpqfeRmLiVQB4TnnInXH5AupK7ofSR80nMEtlrW8q9C6vogrXhka6jDQ3rV6dePfiZ2OuY4p0Suhg8vrnEpNJPUYP7kTvA4vlv1EUuC22qRUR/HsukzXr8OeehOqjr9YsFudJAvf2kUpXNCFaOlu0yIN2M+CtojcqfPX51w=
Message-ID: <86802c440611070859g5bb3c8b0q6b05b4ef2782d682@mail.gmail.com>
Date: Tue, 7 Nov 2006 08:59:53 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Avi Kivity" <avi@qumranet.com>
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <454E4941.7000108@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454E4941.7000108@qumranet.com>
X-Google-Sender-Auth: a4cc26f40a0123b0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, Avi Kivity <avi@qumranet.com> wrote:
> - Windows 64-bit does not work.  That's also true for qemu, so it's
>   probably a problem with the device model.

Windows 64bit could work as guest with qemu latest cvs version.

YH
