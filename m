Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289482AbSAOKYb>; Tue, 15 Jan 2002 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSAOKYV>; Tue, 15 Jan 2002 05:24:21 -0500
Received: from delrom.ro ([193.231.234.28]:5764 "EHLO delrom.ro")
	by vger.kernel.org with ESMTP id <S289482AbSAOKYL>;
	Tue, 15 Jan 2002 05:24:11 -0500
Date: Tue, 15 Jan 2002 12:24:42 +0200
From: Silviu Marin-Caea <silviu@delrom.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: compile error 2.4.17
Message-Id: <20020115122442.444edcc8.silviu@delrom.ro>
In-Reply-To: <20020115121123.78594eb7.silviu@delrom.ro>
In-Reply-To: <20020115121123.78594eb7.silviu@delrom.ro>
Organization: Delta Romania
X-Mailer: Sylpheed version 0.7.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 12:11:23 +0200
Silviu Marin-Caea <silviu@delrom.ro> wrote:

> I'm trying to compile a minimalistic custom kernel for a bootable
> diskette.

If I enable the kernel module loader, compilation works.  I don't need
it, I'm building that kernel with everything compiled in, no modules.

grep "=m" .config shows nothing

-- 
Silviu Marin-Caea - Network & Systems Administrator - Delta Romania
Phone +4093-267961

