Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbVLGWhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbVLGWhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbVLGWhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:37:31 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:58421 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751807AbVLGWh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:37:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CYVEtOp9wDRyqDXkwKBDtVY5LK8IjirojbyGC6JzmYHmzk4TD/HRaHh+tcTz5BS4sLE2nkMv0AQbAuKgzAtxvdaYBcx4ZkE5m/culaDRnwaHzPlAnL/B6zhdzBbsLH9I66OpZsxWvDz4fhy4vXId8cIEsIldgKCX2teaAdQhD8I=
Message-ID: <a762e240512071437v4424b6f2i2f67f39e0fd29c83@mail.gmail.com>
Date: Wed, 7 Dec 2005 14:37:28 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.15-rc4 Oops in show_smaps()
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1133993880.21841.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133993880.21841.49.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Badari Pulavarty <pbadari@us.ibm.com> wrote:
> Hi,
>
> I am getting Oops while doing
>
> cat /proc/<pid>/smaps
>
> Known issue ?

x86_64  2.6.15-rc5 dosen't seem to have this issue.

Thanks,
  Keith
