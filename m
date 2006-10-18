Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422683AbWJRQxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWJRQxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbWJRQxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:53:48 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:43901 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422683AbWJRQxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:53:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=I16xBg7xc2zdQ8Intzaan7y3s7aibCoRYyPn5UzGPanDlGHDDhPBhOEkrFTimASlwXlpG/Tg4rmRGE9LwPN4pgtmszHVdkpcfuiouyERv5QFwvZBXUi88Jz+EBeZ90pGUPNXFfedtL1KYaTGB1fgtGFWpSuncmKkVWLCBLSU4ZU=
Reply-To: andrew.j.wade@gmail.com
To: Edward Shishkin <edward@namesys.com>
Subject: Re: [2.6.19-rc2-mm1] error: too few arguments to function =?utf-8?q?=E2=80=98crypto=5Falloc=5Fhash=E2=80=99?=
Date: Wed, 18 Oct 2006 12:53:39 -0400
User-Agent: KMail/1.9.1
Cc: andrew.j.wade@gmail.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
References: <20061016230645.fed53c5b.akpm@osdl.org> <200610171603.38253.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <453548DD.3000701@namesys.com>
In-Reply-To: <453548DD.3000701@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610181253.39872.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 17:19, Edward Shishkin wrote:
> The fix is attached.
> Andrew, please apply.

The kernel compiles and boots; I don't know how to test that code
specifically. Thanks.

Andrew Wade
