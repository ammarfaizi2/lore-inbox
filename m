Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbWGZPri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbWGZPri (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWGZPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:47:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36327 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751190AbWGZPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:47:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WnUk81qtQjx8j5vhrdm9vfzw9UwEus6Sah4TUB+XkAsZqKjVu8Yq+2K3OLxWH66tRtHAaUtENRMa0lsABRNCR6AuT42Mf8/Ko/PVYv7HuCatRui5i8tu0FvLcaGw1edb9PsVwsIMx3aWWU6jvS+4fyRhmZFNr1pVNmZ7ju+vVTk=
Date: Wed, 26 Jul 2006 19:55:14 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] usb: device unconnect cause oops
Message-Id: <20060726195514.bf78bd96.pauldrynoff@gmail.com>
In-Reply-To: <20060726013949.4eae206b.akpm@osdl.org>
References: <20060726122003.8f99cdea.pauldrynoff@gmail.com>
	<20060726013949.4eae206b.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006 01:39:49 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 26 Jul 2006 12:20:03 +0400
> Paul Drynoff <pauldrynoff@gmail.com> wrote:
> 
> > I used 2.6.18-rc1-mm2.
> > 
> > I have HP LaserJet 1010, it connected to computer via USB,
> > I switched on it, printed something and swithched off it,
> > after that I got in /var/log/messages:
> 
> Was
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch
> applied?

No, I missed it, sorry.
With it I can not reproduce problem.
