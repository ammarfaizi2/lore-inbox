Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288944AbSAVQ6U>; Tue, 22 Jan 2002 11:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289201AbSAVQ6K>; Tue, 22 Jan 2002 11:58:10 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:56570 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288944AbSAVQ6A>; Tue, 22 Jan 2002 11:58:00 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020122022751.P8292@athlon.random> 
In-Reply-To: <20020122022751.P8292@athlon.random>  <20020121175410.G8292@athlon.random> <20020121.141931.105134927.davem@redhat.com> <20020122013743.M8292@athlon.random> <20020121.170745.52090023.davem@redhat.com> 
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, reid.hekman@ndsu.nodak.edu,
        linux-kernel@vger.kernel.org, akpm@zip.com.au, alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Jan 2002 16:57:38 +0000
Message-ID: <16899.1011718658@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrea@suse.de said:
>  that is not a tlb flush, it's a noop on x86 infact.

If these functions weren't quite so stupidly named, this confusion wouldn't 
arise.

--
dwmw2


