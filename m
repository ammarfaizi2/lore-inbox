Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757896AbWKYIks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896AbWKYIks (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757897AbWKYIks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:40:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:45351 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1757896AbWKYIkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:40:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YcXBHM7Nx4d9MLgliItB4l+Sw/QT8Ae9mTuheJ/o+ODS8TeJl/6YP7lcp1wuolc28Kq2YQkQTN43DZFyESv/2r7eF2Piq+VxGrdqQMiKmIqd3/MXxZdLsamFAyjZ25vAj9DbaheaFBIsyYIpK1IKO6GeM4LogZ4jaNtzXNaudvk=
Message-ID: <86802c440611250040t6c18272et495dd72e2eda7d7a@mail.gmail.com>
Date: Sat, 25 Nov 2006 00:40:45 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] x86-64: change the size for interrupt array to NR_VECTORS
Cc: "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@muc.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1psbcovwv.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <86802c440611241736l545ddf33i3bb08f3cd6446b14@mail.gmail.com>
	 <m1psbcovwv.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: d9bcea3afb7bccee
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Yinghai Lu" <yinghai.lu@amd.com> writes:
> YH.  Please place a newline between your subject and your description
> in the body of your patches.

Next time.

> Yep I missed this optimization opportunity :)

You did a great job to clean up the irq_vector mapping.

YH
