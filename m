Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWGGMjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGGMjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWGGMjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:39:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:63688 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932151AbWGGMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:38:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=hBvicenxPprHFKMdWlq8+gkPbCW+QtUP+ACzEeeHRjWXSr3ofGeMlreLz1fehBEKlince2Eqnv2P6R88/LaoHs3rrY7vuPV/W1IP2UnqnIIfFgGDVAMFN1grfwxQiz/KVqrN6wR8GUyCJw3kS7/CJAU4CHWZ/JMReuGWc/G0yzU=
Message-ID: <44AE572D.8000105@innomedia.soft.net>
Date: Fri, 07 Jul 2006 18:14:29 +0530
Reply-To: chinmaya@innomedia.soft.net
Organization: Innomedia Technologies Pvt. Ltd.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Setting kernel thread priority
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Chinmaya Mishra <chinmaya4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using linux kernel 2.6.10.
In a kernel module i am calling two functions in two
kernel threads using the api,

kernel_thread((void *)funName, NULL, CLONE_KERNEL);

Is there any procedure/apis available to set the thread priority?
Please help . . . . .

Thanks in advance.
Chinmaya



