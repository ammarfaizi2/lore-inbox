Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278507AbRJVK7H>; Mon, 22 Oct 2001 06:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278508AbRJVK66>; Mon, 22 Oct 2001 06:58:58 -0400
Received: from ns.ithnet.com ([217.64.64.10]:21514 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278507AbRJVK6w>;
	Mon, 22 Oct 2001 06:58:52 -0400
Date: Mon, 22 Oct 2001 12:59:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: nfs mount of msdos fs?
Message-Id: <20011022125928.2f2a15b9.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just found out, that msdos-type fs cannot be exported via nfs. Disregarding
the security problems with msdos fs, how can I export it anyway via nfs? Is
this possible at all? I tried with 2.2.19 kernel and kernel nfs.

Regards,
Stephan
