Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbVJZIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbVJZIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVJZIT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:19:28 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:24137 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932593AbVJZIT1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:19:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IxnqZM34tLwr+C2UH3dI0JngLDu0Hm2q6+oZJR7PYQT0tSUhio/7xQP/VL3wtcPguiXuDze+pciysrmkzbQT9uJuPJtK4QLbH3uSjDnviyyMVWiMB0dEq3YQhjX3DaMIayTh5+idc7xFpuNywrXqavm7Ku4m890VwBuGxePat90=
Message-ID: <aec7e5c30510260119q7bc66aeal9abb3ac53a3473eb@mail.gmail.com>
Date: Wed, 26 Oct 2005 17:19:26 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CPUSETS: remove SMP dependency
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       pj@sgi.com
In-Reply-To: <20051026010922.5a8f70fe.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051026075345.21014.53533.sendpatchset@cherry.local>
	 <20051026010922.5a8f70fe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Andrew Morton <akpm@osdl.org> wrote:
> Magnus Damm <magnus@valinux.co.jp> wrote:
> >
> > Remove the SMP dependency from CPUSETS.
>
> Why?

http://www.ussg.iu.edu/hypermail/linux/kernel/0510.0/0279.html

/ magnus
